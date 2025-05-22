package com.example.frido_app
import android.app.usage.UsageStatsManager

import android.content.Intent
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.util.Base64
import android.app.AppOpsManager
import android.content.Context
import android.os.Build
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream

class MainActivity: FlutterActivity() {
    private val APPS_CHANNEL = "com.example.app/installed_apps"
    private val USAGE_CHANNEL = "com.example.app/usage_stats"
    private val PERMISSION_CHANNEL = "com.example.permissions/channel"


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, APPS_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getInstalledApps") {
                val apps = getInstalledApps()
                result.success(apps)
            } else {
                result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, USAGE_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getUsageStats") {
                val interval = call.argument<String>("interval") ?: "daily"
                val usageStats = getUsageStats(interval)
                        result.success(usageStats)
            } else {
                result.notImplemented()
            }
       }

       MethodChannel(flutterEngine.dartExecutor.binaryMessenger, PERMISSION_CHANNEL).setMethodCallHandler {
            call, result ->
            when (call.method) {
                "isUsagePermissionGranted" -> {
                    result.success(isUsageStatsPermissionGranted(this))
                }
                "openUsageSettings" -> {
                    openUsageAccessSettings()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }

    }

    private fun getInstalledApps(): List<Map<String, Any>> {
        val pm = applicationContext.packageManager
        val packages = pm.getInstalledApplications(0)
        val appList = mutableListOf<Map<String, Any>>()

        for (packageInfo in packages) {
             if ((packageInfo.flags and android.content.pm.ApplicationInfo.FLAG_SYSTEM) != 0) {
            continue
        }
            val name = pm.getApplicationLabel(packageInfo).toString()
            val packageName = packageInfo.packageName
            val icon = pm.getApplicationIcon(packageInfo)
            val bitmap = drawableToBitmap(icon)
            val stream = ByteArrayOutputStream()
            bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream)
            val iconBase64 = Base64.encodeToString(stream.toByteArray(), Base64.DEFAULT)

            appList.add(mapOf(
                "name" to name,
                "packageName" to packageName,
                "iconBase64" to iconBase64
            ))
        }
        return appList
    }

    private fun drawableToBitmap(drawable: Drawable): Bitmap {
        if (drawable is BitmapDrawable) {
            return drawable.bitmap
        }
        val bitmap = Bitmap.createBitmap(
            drawable.intrinsicWidth.takeIf { it > 0 } ?: 1,
            drawable.intrinsicHeight.takeIf { it > 0 } ?: 1,
            Bitmap.Config.ARGB_8888
        )
        val canvas = Canvas(bitmap)
        drawable.setBounds(0, 0, canvas.width, canvas.height)
        drawable.draw(canvas)
        return bitmap
    }

    private fun getUsageStats(interval: String): List<Map<String, Any>> {
         val pm = applicationContext.packageManager
         val packages = pm.getInstalledApplications(0)
     
         val usageStatsManager = getSystemService(USAGE_STATS_SERVICE) as android.app.usage.UsageStatsManager
         val endTime = System.currentTimeMillis()
         val startTime = when (interval) {
             "daily" -> endTime - 1000 * 60 * 60 * 24
             "weekly" -> endTime - 1000L * 60 * 60 * 24 * 7
             "monthly" -> endTime - 1000L * 60 * 60 * 24 * 30
             "yearly" -> endTime - 1000L * 60 * 60 * 24 * 365
             else -> endTime - 1000 * 60 * 60 * 24
         }
     
         val stats = usageStatsManager.queryUsageStats(
             UsageStatsManager.INTERVAL_DAILY,
             startTime,
             endTime
         )
     
         val usageMap = stats.associateBy { it.packageName }
         val appList = mutableListOf<Map<String, Any>>()
     
         for (app in packages) {
             if ((app.flags and android.content.pm.ApplicationInfo.FLAG_SYSTEM) != 0) continue
     
             val name = pm.getApplicationLabel(app).toString()
             val packageName = app.packageName
             val icon = pm.getApplicationIcon(app)
             val bitmap = drawableToBitmap(icon)
             val stream = ByteArrayOutputStream()
             bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream)
             val iconBase64 = Base64.encodeToString(stream.toByteArray(), Base64.DEFAULT)
     
             val usageTime = usageMap[packageName]?.totalTimeInForeground ?: 0
     
             appList.add(
                 mapOf(
                     "name" to name,
                     "packageName" to packageName,
                     "iconBase64" to iconBase64,
                     "usageTime" to usageTime
                 )
             )
         }
     
         return appList
    }

    private fun isUsageStatsPermissionGranted(context: Context): Boolean {
        val appOps = context.getSystemService(Context.APP_OPS_SERVICE) as AppOpsManager
        val mode = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            appOps.unsafeCheckOpNoThrow(
                AppOpsManager.OPSTR_GET_USAGE_STATS,
                android.os.Process.myUid(),
                context.packageName
            )
        } else {
            appOps.checkOpNoThrow(
                AppOpsManager.OPSTR_GET_USAGE_STATS,
                android.os.Process.myUid(),
                context.packageName
            )
        }
        return mode == AppOpsManager.MODE_ALLOWED
    }

    private fun openUsageAccessSettings() {
        val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
        startActivity(intent)
    }

}