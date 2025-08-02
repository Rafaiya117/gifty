import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bestwe2_0/app_State/auth_service.dart';
import 'package:bestwe2_0/app_State/giftpot_state.dart';
import 'package:bestwe2_0/app_State/static_content_state.dart';
import 'package:bestwe2_0/app_state/user_state.dart';
import 'package:bestwe2_0/services/auth_service.dart';
import 'package:bestwe2_0/services/user_services.dart';

class ApplicationState extends ChangeNotifier {
  late final Dio _dio;
  late final String apiKey;
  late final String baseUrl;

  late final AuthState authState;
  late final UserState userState;
  late final GiftpotState giftpotState;
  late final StaticContentState staticContentState;


  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  final Completer<void> _initCompleter = Completer<void>();

  ApplicationState() {
    _initializeSafely();
  }

  Future<void> _initializeSafely() async {
    try {
      await init();
      _initCompleter.complete();
    } catch (e) {
      _initCompleter.completeError(e);
      rethrow;
    }
  }

  /// Call this from widgets that depend on data.
  Future<void> ensureInitialized() => _initCompleter.future;

  Future<void> init() async {
    if (_isInitialized) return;

    await dotenv.load(fileName: ".env");
    print("!.........................Initialized.........................!");

    baseUrl = dotenv.env['API_BASE_URL'] ?? '';
    _dio = Dio(BaseOptions(baseUrl: baseUrl));

    final prefs = await SharedPreferences.getInstance();
    apiKey = prefs.getString('auth_token') ?? '';

    final userService = UserServices(dio: _dio);

    // Initialize services
    final authServiceInstance = AuthService(dio: _dio, baseUrl: baseUrl, apiKey: apiKey);
    final userStateInstance = UserState(userService, _dio, apiKey);
    final giftpotStateInstance = GiftpotState(_dio, apiKey);


    // Assign to fields
    authState = AuthState(authServiceInstance);
    userState = userStateInstance;
    giftpotState = giftpotStateInstance;
    staticContentState = StaticContentState(userService);


    // Fetch initial data
     userState.fetchUser();
    print(".......userdata loaded.........");
    giftpotState.fetchNotifications();
    giftpotState.fetchNotes();
    await Future.wait([
      staticContentState.fetchPrivacy(),
      staticContentState.fetchTerms(),
      staticContentState.fetchAboutUs(),
      giftpotState.fetchGifts(),
      giftpotState.fetchGiftRecommendationsData(
        occasion: '',
        priceRange: '',
      ),
      giftpotState.fetchGiftRecommendation(
        userName: '',
        occasion: giftpotState.selectedOccasion ?? '',
        priceRange: giftpotState.selectedPriceRange ?? '',
        responseFormData: giftpotState.responseFormAnswers,
      ),
    ]);

    _isInitialized = true;
    notifyListeners();
  }
}
