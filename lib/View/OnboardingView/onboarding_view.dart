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
                title: "What is frido?",
                description:
                    "Frido helps you track your daily behaviors and rewards your consistency.",
                image: "assets/images/onboarding_image_1.png",
              ),
              buildPage(
                title: "Why Usage Data?",
                description:
                    "We use your behavior data to show you relevant and valuable offers.",
                image: "assets/images/onboarding_image_2.png",
              ),
              buildPage(
                title: "How Rewards Work?",
                description:
                    "Complete personalized offers to earn exciting rewards and benefits!",
                image: "assets/images/onboarding_image_3.png",
              ),
            ],
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child:
                isLastPage
                    ? MyButton(
                      onTap: () {
                        Get.off(() => const SignUpView());
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
                            style: TextStyle(color: blackColor),
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
                          child: Image.asset(
                            "assets/images/next_btn.png",
                            fit: BoxFit.cover,
                            scale: 4,
                            filterQuality: FilterQuality.high,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Image.asset(image, height: 250, fit: BoxFit.cover)),
          myHeight(0.06),
          Text(
            title,
            style: const TextStyle(fontSize: 32,fontWeight: FontWeight.w600 , color: Color.fromARGB(255, 0, 42, 81)),
          ),
          myHeight(0.02),
          Text(
            description,
            style: const TextStyle(color: Color(0XFF004E97), fontSize: 18),
          ),
        ],
      ),
    );
  }
}
