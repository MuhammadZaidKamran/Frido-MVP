package com.example.frido_app

import android.app.usage.UsageStatsManager
import android.content.pm.PackageManager
import android.graphics.drawable.BitmapDrawable
import android.os.Bundle
import android.util.Base64
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream

import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.AdaptiveIconDrawable


class MainActivity : FlutterActivity() {
    private val USAGE_STATS_CHANNEL = "com.example.app/usage_stats"
    private val PERMISSIONS_CHANNEL = "com.example.permissions/channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Usage Stats Method Channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, USAGE_STATS_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getUsageStats" -> {
                    val stats = getUsageStats()
                    result.success(stats)
                }
                else -> result.notImplemented()
            }
        }

        // Permissions Method Channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, PERMISSIONS_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "isUsagePermissionGranted" -> {
                    val appOps = getSystemService(APP_OPS_SERVICE) as android.app.AppOpsManager
                    val mode = appOps.checkOpNoThrow(
                        "android:get_usage_stats",
                        android.os.Process.myUid(),
                        packageName
                    )
                    val granted = mode == android.app.AppOpsManager.MODE_ALLOWED
                    result.success(granted)
                }
                "openUsageSettings" -> {
                    val intent = android.content.Intent(android.provider.Settings.ACTION_USAGE_ACCESS_SETTINGS)
                    intent.flags = android.content.Intent.FLAG_ACTIVITY_NEW_TASK
                    startActivity(intent)
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }


    private fun drawableToBitmap(drawable: android.graphics.drawable.Drawable): Bitmap {
      if (drawable is android.graphics.drawable.BitmapDrawable) {
        return drawable.bitmap
      }

      // For AdaptiveIconDrawable or other drawable types
      val bitmap = Bitmap.createBitmap(
        drawable.intrinsicWidth.takeIf { it > 0 } ?: 1,
        drawable.intrinsicHeight.takeIf { it > 0 } ?: 1,
        Bitmap.Config.ARGB_8888
      )
      val canvas = android.graphics.Canvas(bitmap)
      drawable.setBounds(0, 0, canvas.width, canvas.height)
      drawable.draw(canvas)
      return bitmap
    }



    private fun getUsageStats(): List<Map<String, Any>> {
    val pm = applicationContext.packageManager
    val packages = pm.getInstalledApplications(PackageManager.GET_META_DATA)

    val usageStatsManager = getSystemService(USAGE_STATS_SERVICE) as UsageStatsManager
    val now = System.currentTimeMillis()

    val intervals = listOf(
        "daily" to (now - 1000L * 60 * 60 * 24),
        "weekly" to (now - 1000L * 60 * 60 * 24 * 7),
        "monthly" to (now - 1000L * 60 * 60 * 24 * 30),
        "yearly" to (now - 1000L * 60 * 60 * 24 * 365)
    )

    val usageMap = mutableMapOf<String, MutableMap<String, Long>>()
    val lastUsedMap = mutableMapOf<String, Long>()

    for ((intervalName, startTime) in intervals) {
        val stats = usageStatsManager.queryUsageStats(
            UsageStatsManager.INTERVAL_DAILY,
            startTime,
            now
        )

        for (usage in stats) {
            val pkg = usage.packageName
            if (!usageMap.containsKey(pkg)) {
                usageMap[pkg] = mutableMapOf()
            }
            usageMap[pkg]?.set(intervalName, (usageMap[pkg]?.get(intervalName) ?: 0) + usage.totalTimeInForeground)

            if (!lastUsedMap.containsKey(pkg) || usage.lastTimeUsed > lastUsedMap[pkg] ?: 0) {
                lastUsedMap[pkg] = usage.lastTimeUsed
            }
        }
    }

    val appList = mutableListOf<Map<String, Any>>()
    for (app in packages) {
        if ((app.flags and android.content.pm.ApplicationInfo.FLAG_SYSTEM) != 0) continue

        val name = pm.getApplicationLabel(app).toString()
        val packageName = app.packageName
        val icon = pm.getApplicationIcon(app)

        // Convert drawable to bitmap safely
        val bitmap = drawableToBitmap(icon)

        val stream = ByteArrayOutputStream()
        bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream)
        val iconBase64 = Base64.encodeToString(stream.toByteArray(), Base64.DEFAULT)

        val usageTimes = usageMap[packageName] ?: mapOf()

        appList.add(
            mapOf(
                "name" to name,
                "packageName" to packageName,
                "iconBase64" to iconBase64,
                "lastTimeUsed" to (lastUsedMap[packageName] ?: 0),
                "usageStats" to usageTimes
            )
        )
    }

    return appList
}
}
