import 'package:frido_app/Global/colors.dart';
import 'package:frido_app/Global/global.dart';
import 'package:frido_app/View/Auth/sign_up_view.dart';
import 'package:frido_app/Widgets/my_button.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() => isLastPage = index == 2);
            },
            children: [
              _buildPage(
                title: "Your Data. Your Rules.",
                description: "Every tap, scroll, and swipe tells a story — your story. Frido helps you take control of your digital behavior and turn it into value, on your terms.",
                image: "assets/images/onboard1.png",
              ),
              _buildPage(
                title: "Earn From Your Attention",
                description: "Brands pay millions to reach people like you With Frido, you get paid simply being you — viewing, engaging, or even just receiving offers.",
                image: "assets/images/onboard2.png",
              ),
              _buildPage(
                title: "Masked. Secure. Always.",
                description: "Your personal identity stays hidden. Frido uses personas to match you with relevant promotions — privacy-first, always.",
                image: "assets/images/onboard3.png",
              ),
            ],
          ),
          Positioned(
            bottom: 60,
            left: 20,
            right: 20,
            child: isLastPage
                ? MyButton(
                    onTap: () => Get.off(() =>  SignUpView()),
                    label: "Get Started",
                    gradient: LinearGradient(
                      colors: [mainThemeColor, Colors.purple[600]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => _controller.jumpToPage(2),
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            color: mainThemeColor, // Using theme color
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SmoothPageIndicator(
                        controller: _controller,
                        count: 3,
                        effect: ExpandingDotsEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          activeDotColor: mainThemeColor,
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [mainThemeColor, Colors.purple[600]!],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          },
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage({
    required String title,
    required String description,
    required String image,
  }) {
    return Padding(
      padding: myPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 300, fit: BoxFit.contain),
          myHeight(0.06),
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: mainThemeColor, // Using theme color for headings
            ),
            textAlign: TextAlign.center,
          ),
          myHeight(0.02),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}