import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softlab_auth/constants/image_constants.dart';
import 'package:softlab_auth/constants/keys.dart';
import 'package:softlab_auth/features/auth/onboarding/onboarding_page.dart';
import 'package:softlab_auth/helper/routes.dart';
import 'package:softlab_auth/utils/local_storage.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'image': Images.onboarding1,
      'title': 'Quality',
      'desc':
          'Sell your farm fresh products directly to consumers, '
          'cutting out the middleman and reducing emissions.',
      'color': Color(0xff5EA25F),
    },
    {
      'image': Images.onboarding2,
      'title': 'Fast Delivery',
      'desc':
          'Get your orders delivered fresh to your doorstep '
          'within hours of harvest.',
      'color': Color(0xffD5715B),
    },
    {
      'image': Images.onboarding3,
      'title': 'Trusted Farmers',
      'desc':
          'Connect with verified local farmers and support '
          'sustainable agriculture.',
      'color': Color(0xffF8C569),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4CAF50),
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: _pages.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder:
                (_, i) => OnboardingPage(
                  image: _pages[i]['image']!,
                  title: _pages[i]['title']!,
                  desc: _pages[i]['desc']!,
                  currentIndex: _currentPage,
                  total: _pages.length,
                  color: _pages[i]['color'],
                  onJoin: () {
                    LocalStorage.setStringData(key: Keys.isOnboardSetup, value: "true");
                    Get.offNamed(Routes.getRegisterStep1());
                  },
                  login: () {
                    LocalStorage.setStringData(key: Keys.isOnboardSetup, value: "true");
                    Get.offNamed(Routes.getLoginView());
                  },
                ),
          ),
        ],
      ),
    );
  }
}
