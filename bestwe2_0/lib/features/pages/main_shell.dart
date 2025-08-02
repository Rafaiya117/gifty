import 'package:bestwe2_0/features/pages/chatbot_screen.dart';
import 'package:bestwe2_0/features/pages/home_page_screen.dart';
import 'package:bestwe2_0/features/pages/profile_screen.dart';
import 'package:bestwe2_0/widgets/bottom_navbar_screen.dart';
import 'package:flutter/material.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  final ValueNotifier<MainTab> _currentTab = ValueNotifier(MainTab.home);

  @override
  void dispose() {
    _currentTab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<MainTab>(
      valueListenable: _currentTab,
      builder: (context, tab, _) {
        Widget body;
        switch (tab) {
          case MainTab.home:
            body = const HomeScreen();
            break;
          case MainTab.chatbot:
            body = const ChatbotScreen();
            break;
          case MainTab.profile:
            body = const ProfileScreen();
            break;
        }

        return Scaffold(
          body: body,
          bottomNavigationBar: BottomNavBar(
            currentTab: tab,
            onTabSelected: (selected) {
              _currentTab.value = selected;
            },
          ),
        );
      },
    );
  }
}
