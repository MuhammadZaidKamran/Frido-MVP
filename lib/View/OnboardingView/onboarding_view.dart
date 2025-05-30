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
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
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
              setState(
                () => index == 2 ? isLastPage = true : isLastPage = false,
              );
            },
            children: [
              buildPage(
                title: "Your Data. Your Rules.",
                description:
                    "Every tap, scroll, and swipe tells a story — your story. Frido helps you take control of your digital behavior and turn it into value, on your terms.",
                image: "assets/images/onboard1.png",
              ),
              buildPage(
                title: "Earn From Your Attention",
                description:
                    "Brands pay millions to reach people like you With Frido, you get paid simply being you — viewing, engaging, or even just receiving offers.",
                image: "assets/images/onboard2.png",
              ),
              buildPage(
                title: "Masked. Secure. Always.",
                description:
                    "Your personal identity stays hidden. Frido uses  personas to match you with relevant promotions — privacy-first, always.",
                image: "assets/images/onboard3.png",
              ),
            ],
          ),
          Positioned(
            bottom: 60,
            left: 20,
            right: 20,
            child:
                isLastPage
                    ? MyButton(
                      onTap: () {
                        Get.off(() =>  SignUpView());
                      },
                      label: "Get Started",
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            _controller.jumpToPage(2);
                          },
                          child: Text(
                            "Skip",
                            style: TextStyle(
                              color: Colors.black45,
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
                        InkWell(
                          onTap: () {
                            _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          },
                          child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: LinearGradient(
                                colors: [Color(0xffA774FE), Color(0xff4C1F99)],
                                end: Alignment.bottomCenter,
                                begin: Alignment.topCenter,
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 32,
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

  Widget buildPage({
    required String title,
    required String description,
    required String image,
  }) {
    return Padding(
      padding: myPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset(image, height: 300, fit: BoxFit.cover)),
          myHeight(0.06),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          myHeight(0.02),
          Text(
            description,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
