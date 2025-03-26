import 'package:everyattire/constants/color_constants.dart';
import 'package:everyattire/screens/authentication_screen/register_screen.dart';
import 'package:everyattire/screens/onboarding_screen/intro_page_1.dart';
import 'package:everyattire/screens/onboarding_screen/intro_page_2.dart';
import 'package:everyattire/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../authentication_screen/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  // DotDecoration _decoration = DotDecoration();
  int activePage = 0;

  final List<Widget> pages = [
    Container(
      color: Colors.transparent,
      child: SecondIntroPage(),
    ),
    Container(
      color: Colors.transparent,
      child: FirstIntroPage(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _onchanged(int index) {
    setState(() {
      activePage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [

          Expanded(
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              onPageChanged: _onchanged,
              controller: _pageController,
              itemCount: pages.length,
              itemBuilder: (context, int index) {
                return pages[index];
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 16, bottom: 35),
            width: screenWidth,
            decoration: BoxDecoration(
              color: kSecondaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                    List.generate(pages.length, (int index) {
                      return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 12,
                          width: (index == activePage) ? 30 : 10,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 30),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: (index == activePage)
                                  ? Colors.white
                                  : Colors.orange));
                    })),

                AppButton(

                  buttonText: "Continue →",
                  buttonColor: Colors.white,
                  buttonTextColor: kPrimaryColor,
                  buttonTextPadding: 20,
                  onPressed: ()  {
                    if (activePage == pages.length - 1) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                    } else {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeInOutQuint);
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}
