import 'package:bestwe2_0/features/auth/change_password_screen.dart';
import 'package:bestwe2_0/features/auth/forgot_password_screen.dart';
import 'package:bestwe2_0/features/auth/otp_verification_screen.dart';
import 'package:bestwe2_0/features/auth/reset_password_screen.dart';
import 'package:bestwe2_0/features/pages/gift_pot_screen.dart';
import 'package:bestwe2_0/features/pages/main_shell.dart';
import 'package:bestwe2_0/features/pages/personal_match_feeling_screen.dart';
import 'package:bestwe2_0/features/pages/personal_match_final_screen.dart';
import 'package:bestwe2_0/features/pages/personal_match_meaning_screen.dart';
import 'package:bestwe2_0/features/pages/personal_match_reason_screen.dart';
import 'package:bestwe2_0/features/pages/personal_match_recommanded_memory_screen.dart';
import 'package:bestwe2_0/features/pages/personal_match_result_screen.dart';
import 'package:bestwe2_0/features/pages/personal_match_result_memory_maker.dart';
import 'package:bestwe2_0/features/pages/personal_match_screen.dart';
import 'package:bestwe2_0/features/pages/personal_match_thinking_screen.dart';
import 'package:bestwe2_0/features/pages/personal_match_ultimate_meaning_screen.dart';
import 'package:bestwe2_0/features/pages/personal_match_what_proud_screen.dart';
import 'package:bestwe2_0/features/pages/personal_match_why_gift_screen.dart';
import 'package:bestwe2_0/features/pages/profile_information_sreen.dart';
import 'package:bestwe2_0/features/pages/shared_giving_suggestion_screen.dart';
import 'package:bestwe2_0/model/giftpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/login.dart';
import '../features/auth/signup_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/pages/about_us_screen.dart';
import '../features/pages/by_share_screen.dart';
import '../features/pages/contribute_now_screen.dart';
import '../features/pages/curated_screen.dart';
import '../features/pages/help_and_support.dart';
import '../features/pages/manage_subscription_screen.dart';
import '../features/pages/notification_screen.dart';
import '../features/pages/payment_method_screen.dart';
import '../features/pages/personal_match_question_screen.dart';
import '../features/pages/preffered_price_point_screen.dart';
import '../features/pages/privacy_policy_screen.dart';
import '../features/pages/reminder_screen.dart';
import '../features/pages/set_reminder_screen.dart';
import '../features/pages/setting_screen.dart';
import '../features/pages/start_giving_screen.dart';
import '../features/pages/subscription_plan_screen.dart';
import '../features/pages/terms_and_service_screen.dart';
import '../features/splash/splash_screen.dart';
import '../features/welcome_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/otp-verification/:email',
      builder: (context, state) => OtpVerificationScreen(email: state.pathParameters['email'] ?? ''),
    ),
    GoRoute(
      path: '/reset-password/:email/:otp',
      // builder: (context, state) => const ResetPasswordScreen(),
      builder: (context, state) {
        final email = Uri.decodeComponent(state.pathParameters['email']!);
        final otp = state.pathParameters['otp']!;
        return ResetPasswordScreen(email: email, otp: otp);
      },
    ),
    GoRoute(
      path: '/main',
      builder: (context, state) => MainShell(),
    ),
    GoRoute(
      path: '/profile-information',
      builder: (context, state) => const ProfileInformationScreen(),
    ),
    GoRoute(
      path: '/change-password',
      builder: (context, state) => const ChangePasswordScreen(),
    ),
    GoRoute(
      path: '/manage-subscription',
      builder: (context, state) => const ManageSubscriptionScreen(),
    ),
    GoRoute(
      path: '/subscription-plan',
      builder: (context, state) => const SubscriptionPlanScreen(),
    ),
    GoRoute(
      path: '/by-share',
      builder: (context, state) => const ByShareScreen(),
    ),
    GoRoute(
      path: '/contribute-now',
      builder: (context, state) => const ContributeNowScreen(),
    ),
    GoRoute(
      path: '/payment-method',
      builder: (context, state) => const PaymentMethodScreen(),
    ),
    GoRoute(
      path: '/reminder',
      builder: (context, state) => const ReminderScreen(),
    ),
    // GoRoute(
    //   path: '/set-reminder',
    //   builder: (context, state) => const SetReminderScreen(),
    // ),
    GoRoute(
      path: '/set-reminder',
      builder: (context, state) {
        final selectedDate = state.extra as DateTime;
        return SetReminderScreen(selectedDate: selectedDate);
      },
    ),

    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/privacy-policy',
      builder: (context, state) => const PrivacyPolicyScreen(),
    ),
    GoRoute(
      path: '/terms-of-service',
      builder: (context, state) => const TermsOfServiceScreen(),
    ),
    GoRoute(
      path: '/help-and-support',
      builder: (context, state) => const HelpAndSupportScreen(),
    ),
    GoRoute(
      path: '/about-us',
      builder: (context, state) => const AboutUsScreen(),
    ),
    // GoRoute(
    //   path: '/preferred-price-point',
    //   builder: (context, state) => const PreferredPricePointScreen(),
    // ),
    GoRoute(
      path: '/preferred-price-point',
      builder: (context, state) {
        final label = state.uri.queryParameters['label'] ?? '';
        print('DEBUG: label from URL = $label'); // 🔍 Debug print
        return PreferredPricePointScreen(label: label);
      },
    ),

    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationsScreen(),
    ),
    // GoRoute(
    //   path: '/start-giving',
    //   builder: (context, state) => const StartGivingScreen(),
    // ),
    GoRoute(
      path: '/start-giving',
      builder: (context, state) {
        final extra = state.extra as Map<String, String>;
        final label = extra['label'] ?? '';
        final price = extra['price'] ?? '';
        print('DEBUG: label = $label, price = $price'); // 🔍 Debug print
        return StartGivingScreen(label: label, price: price);
      },
    ),

    GoRoute(
      path: '/curated-picks',
      builder: (context, state) => const CuratedPicksScreen(occasion: '', priceRange: '',),
    ),
    // GoRoute(
    //   path: '/curated-picks',
    //   builder: (context, state) {
    //     final List<GiftRecommendation> recommendations = state.extra as List<GiftRecommendation>? ?? [];
    //     return CuratedPicksScreen(recommendations: recommendations);
    //   },
    // ),
    GoRoute(
      path: '/personal-match-question',
      builder: (context, state) => const PersonalMatchQuestionScreen(),
    ),
    GoRoute(
      path: '/personal-match-result',
      builder: (context, state) => const PersonalMatchResultScreen(),
    ),
    GoRoute(
      path: '/personal-match-final',
      builder: (context, state) => const PersonalMatchFinalScreen(),
    ),
    GoRoute(
      path: '/personal-match-feeling',
      builder: (context, state) => const PersonalMatchFeelingScreen(),
    ),
    GoRoute(
      path: '/personal-match-reason',
      builder: (context, state) => const PersonalMatchReasonScreen(),
    ),
    GoRoute(
      path: '/personal-match-why-gift',
      builder: (context, state) => const PersonalMatchWhyGiftScreen(),
    ),
    GoRoute(
      path: '/personal-match-what-proud',
      builder: (context, state) => const PersonalMatchWhatProudScreen(),
    ),
    GoRoute(
      path: '/personal-match-feel',
      builder: (context, state) => const PersonalMatchFeelScreen(),
    ),
    GoRoute(
      path: '/personal-match-meaning',
      builder: (context, state) => const PersonalMatchMeaningScreen(),
    ),
    GoRoute(
      path: '/personal-match-how-think',
      builder: (context, state) => const PersonalMatchHowThinkScreen(),
    ),
    GoRoute(
      path: '/personal-match-ultimate-meaning',
      builder: (context, state) => const PersonalMatchUltimateMeaningScreen(),
    ),
    GoRoute(
      path: '/personal-match-result-memory-maker',
      builder: (context, state) => const PersonalMatchResultMemoryMakerScreen(),
    ),
    GoRoute(
      path: '/personal-match-recommend-memory-maker',
      builder: (context, state) => const PersonalMatchRecommendMemoryMakerScreen(),
    ),
    GoRoute(
      path: '/shared-giving-suggestions',
      builder: (context, state) => const SharedGivingSuggestionsScreen(occasion: '', priceRange: '',),
      // builder: (context, state) {
      //   final List<GiftRecommendation> recommendations = state.extra as List<GiftRecommendation>? ?? [];
      //   return SharedGivingSuggestionsScreen(recommendations: recommendations);
      // },
    ),
    GoRoute(
      path: '/gift-pot',
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>?;
        return GiftPotScreen(
          image: args?['image'] ?? '',
          title: args?['title'] ?? '',
        );
      },
    ),
    //     // Add more routes here
  ],
); 