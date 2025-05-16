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
                title: "Slide 01",
                // description:
                //     "Stay on top of your work with an intuitive task manager.",
                // image: "assets/images/task1.png",
              ),
              buildPage(
                title: "Slide 02",
                // description:
                //     "Stay on top of your work with an intuitive task manager.",
                // image: "assets/images/task1.png",
              ),
              buildPage(
                title: "Slide 03",
                // description:
                //     "Boost your efficiency with reminders and scheduling.",
                // image: "assets/images/task2.png",
              ),
            ],
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: blackColor,
                  ),
                ),
                myHeight(0.06),
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
                        MyButton(
                          width: Get.width * 0.4,
                          secondary: true,
                          onTap: () {
                            _controller.jumpToPage(2);
                          },
                          label: "Skip",
                        ),
                        MyButton(
                          width: Get.width * 0.4,
                          onTap: () {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          },
                          label: "Next",
                        ),
                      ],
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
    // required String description,
    // required String image,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image.asset(
        //   image,
        //   height: 250,
        //   fit: BoxFit.cover,
        // ),
        // myHeight(0.06),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        // myHeight(0.03),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 40),
        //   child: Text(description, textAlign: TextAlign.center),
        // ),
      ],
    );
  }
}
