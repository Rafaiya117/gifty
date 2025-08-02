import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

enum MainTab { home, chatbot, profile }

class BottomNavBar extends StatelessWidget {
  final MainTab currentTab;
  final ValueChanged<MainTab> onTabSelected;
  const BottomNavBar({super.key, required this.currentTab, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(17, 12, 46, 0.08),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _NavBarItem(
                icon: Icons.home,
                label: 'Home',
                selected: currentTab == MainTab.home,
                onTap: () => onTabSelected(MainTab.home),
              ),
              _NavBarItem(
                icon: Icons.smart_toy,
                label: 'Chatbot',
                selected: currentTab == MainTab.chatbot,
                onTap: () => onTabSelected(MainTab.chatbot),
              ),
              _NavBarItem(
                icon: Icons.person,
                label: 'Profile',
                selected: currentTab == MainTab.profile,
                onTap: () => onTabSelected(MainTab.profile),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _NavBarItem({required this.icon, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: selected ? const Color(0xFF5B4025) : Colors.grey, size: 28.sp),
          SizedBox(height: 4.h),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              color: selected ? const Color(0xFF5B4025) : Colors.grey,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
