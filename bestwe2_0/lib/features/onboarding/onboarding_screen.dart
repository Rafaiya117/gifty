import 'package:bestwe2_0/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });

    // Navigate after reaching the last page
    if (index == 2) {
      Future.delayed(const Duration(seconds: 1), () {
        context.go('/welcome');
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F3),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: _onPageChanged,
                children: const [
                  _OnboardingPage(
                    image: AppAssets.onboard1,
                    title: 'Practical',
                    subtitle: 'You Matters',
                  ),
                  _OnboardingPage(
                    image: AppAssets.onboard2,
                    title: 'Parsonal',
                    subtitle: 'As unique as you are',
                  ),
                  _OnboardingPage(
                    image: AppAssets.onboard3,
                    title: 'Thoughtful',
                    subtitle: 'I See You',
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            _PageIndicator(currentIndex: _currentPage),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const _OnboardingPage({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 32.h),
        Image.asset(image, height: 320.h),
        SizedBox(height: 32.h),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF5B4025),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: 22.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF5B4025),
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final int currentIndex;
  const _PageIndicator({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 6.w),
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentIndex
                ? const Color(0xFF5B4025)
                : const Color(0xFFD9D9D9),
          ),
        );
      }),
    );
  }
}
