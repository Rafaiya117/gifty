// class ApplicationState extends ChangeNotifier {
//   late final Dio _dio;
//   late final String apiKey;
//   late final String baseUrl;

//   late final AuthState authState;
//   late final UserState userState;
//   late final GiftpotState giftpotState;
//   late final StaticContentState staticContentState;

//   bool _isInitialized = false;
//   bool get isInitialized => _isInitialized;

//   ApplicationState() {
//     init();
//   }

//   Future<void> init() async {
//     if (_isInitialized) return;
//    await dotenv.load(fileName: ".env");
//    print("!.........................Initialized.........................!");
//     apiKey = dotenv.env['AUTH_TOKEN'] ?? '';
//     baseUrl = dotenv.env['API_BASE_URL'] ?? '';
//     _dio = Dio(BaseOptions(baseUrl: baseUrl));

//     final authService = AuthService(dio: _dio, baseUrl: baseUrl, apiKey: apiKey);
//     final userService = UserServices(dio: _dio);

//     authState = AuthState(authService);
//     userState = UserState(userService, _dio, apiKey);
//     giftpotState = GiftpotState(_dio, apiKey);
//     staticContentState = StaticContentState(userService);

//     userState.fetchUser();

//     await Future.wait([
//      staticContentState.fetchPrivacy(),
//      staticContentState.fetchTerms(),
//      staticContentState.fetchAboutUs(),

//      giftpotState.fetchNotifications(),
//      giftpotState.fetchGifts(),
//      giftpotState.fetchGiftRecommendationsData(occasion: '', priceRange: ''),
//      giftpotState.fetchGiftRecommendation(userName: '', occasion: giftpotState.selectedOccasion ?? '', priceRange: giftpotState.selectedPriceRange ?? '', responseFormData: giftpotState.responseFormAnswers,),
    

//     ]);
//     _isInitialized = true;
//     notifyListeners();
//   }
// }



//....................................................//
// class ApplicationState extends ChangeNotifier {
//   late final Dio _dio;
//   late final String apiKey;
//   late final String baseUrl;

//   late final AuthState authState;
//   late final UserState userState;
//   late final GiftpotState giftpotState;
//   late final StaticContentState staticContentState;

//   bool _isInitialized = false;
//   bool get isInitialized => _isInitialized;

//   ApplicationState() {
//     init();
//   }

//   Future<void> init() async {
//     if (_isInitialized) return;
//    await dotenv.load(fileName: ".env");
//    print("!.........................Initialized.........................!");
//     apiKey = dotenv.env['AUTH_TOKEN'] ?? '';
//     baseUrl = dotenv.env['API_BASE_URL'] ?? '';
//     _dio = Dio(BaseOptions(baseUrl: baseUrl));

//     final authService = AuthService(dio: _dio, baseUrl: baseUrl, apiKey: apiKey);
//     final userService = UserServices(dio: _dio);

//     authState = AuthState(authService);
//     userState = UserState(userService, _dio, apiKey);
//     giftpotState = GiftpotState(_dio, apiKey);
//     staticContentState = StaticContentState(userService);

//     userState.fetchUser();

//     await Future.wait([
//      staticContentState.fetchPrivacy(),
//      staticContentState.fetchTerms(),
//      staticContentState.fetchAboutUs(),

//      giftpotState.fetchNotifications(),
//      giftpotState.fetchGifts(),
//      giftpotState.fetchGiftRecommendationsData(occasion: '', priceRange: ''),
//      giftpotState.fetchGiftRecommendation(userName: '', occasion: giftpotState.selectedOccasion ?? '', priceRange: giftpotState.selectedPriceRange ?? '', responseFormData: giftpotState.responseFormAnswers,),
    

//     ]);
//     _isInitialized = true;
//     notifyListeners();
//   }
// }


// class ApplicationState extends ChangeNotifier {
//   late Dio _dio;
//   late String apiKey;
//   late String baseUrl;

//   late final AuthState authState;
//   late UserState userState;
//   late GiftpotState giftpotState;
//   late StaticContentState staticContentState;

//   bool _isInitialized = false;
//   bool get isInitialized => _isInitialized;

//   final Completer<void> _initCompleter = Completer<void>();

//   ApplicationState() {
//     _initializeSafely();
//   }

//   Future<void> _initializeSafely() async {
//     try {
//       await init();
//       _initCompleter.complete();
//     } catch (e) {
//       _initCompleter.completeError(e);
//       rethrow;
//     }
//   }

//   Future<void> ensureInitialized() => _initCompleter.future;

//   Future<void> init() async {
//     if (_isInitialized) return;

//     await dotenv.load(fileName: ".env");
//     print("!.........................Initialized.........................!");

//     baseUrl = dotenv.env['API_BASE_URL'] ?? '';
//     apiKey = await _loadTokenFromPrefs() ?? dotenv.env['AUTH_TOKEN'] ?? '';

//     _dio = Dio(BaseOptions(
//       baseUrl: baseUrl,
//       headers: {
//         'Authorization': 'Bearer $apiKey',
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//       },
//     ));

//     final authService = AuthService(dio: _dio, baseUrl: baseUrl);
//     final userService = UserServices(dio: _dio);

//     authState = AuthState(authService);
//     userState = UserState(userService, _dio);
//     giftpotState = GiftpotState(_dio);
//     staticContentState = StaticContentState(userService);

//     userState.fetchUser();
//     giftpotState.fetchNotifications();

//     await Future.wait([
//       staticContentState.fetchPrivacy(),
//       staticContentState.fetchTerms(),
//       staticContentState.fetchAboutUs(),
//       giftpotState.fetchGifts(),
//       giftpotState.fetchGiftRecommendationsData(
//         occasion: '',
//         priceRange: '',
//       ),
//       giftpotState.fetchGiftRecommendation(
//         userName: '',
//         occasion: giftpotState.selectedOccasion ?? '',
//         priceRange: giftpotState.selectedPriceRange ?? '',
//         responseFormData: giftpotState.responseFormAnswers,
//       ),
//     ]);

//     _isInitialized = true;
//     notifyListeners();
//   }

//   /// Save auth token to SharedPreferences and update Dio + dependent states
//   Future<void> saveTokenToPrefs(String token) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('authToken', token);
//     apiKey = token;

//     // Update Dio headers
//     _dio.options.headers['Authorization'] = 'Bearer $token';

//     // Recreate states if needed
//     userState = UserState(UserServices(dio: _dio), _dio);
//     giftpotState = GiftpotState(_dio);

//     notifyListeners();
//   }

//   /// Load token from SharedPreferences
//   Future<String?> _loadTokenFromPrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('authToken');
//   }

//   /// Clear saved token (e.g., on logout)
//   Future<void> clearToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('authToken');
//     apiKey = '';
//     _dio.options.headers.remove('Authorization');
//     notifyListeners();
//   }
// }


//...................................giftpot_state.dart...................................//
// class GiftpotState extends ChangeNotifier {
//   final Dio _dio;

//   GiftpotState(this._dio);

//   List<GiftPot> _giftList = [];
//   List<GiftPot> get giftList => _giftList;

//   List<GiftRecommendation> _recommendations = [];
//   List<GiftRecommendation> get recommendations => _recommendations;

//   List<Note> _notes = [];
//   List<Note> get notes => _notes;

//   String? selectedOccasion;
//   String? selectedPriceRange;
//   final List<ResponseFormItem> responseFormAnswers = [];

//   void setOccasionAndPrice({
//     required String occasion,
//     required String priceRange,
//   }) {
//     selectedOccasion = occasion;
//     selectedPriceRange = priceRange;
//     responseFormAnswers.clear();
//     notifyListeners();
//   }

//   void addResponseFormAnswer(ResponseFormItem item) {
//     responseFormAnswers.add(item);
//     notifyListeners();
//   }

//   void clearResponseFormAnswers() {
//     responseFormAnswers.clear();
//     notifyListeners();
//   }

//   Future<void> fetchGifts() async {
//     try {
//       final response = await _dio.get('/giftpots/');

//       if (response.statusCode == 200) {
//         final data = response.data;
//         if (data is List) {
//           _giftList = data.map((e) => GiftPot.fromJson(e)).toList();
//         }
//       }
//     } catch (e) {
//       print('Gift fetch error: $e');
//     }
//     notifyListeners();
//   }

//   Future<void> fetchGiftRecommendationsData({
//     required String occasion,
//     required String priceRange,
//   }) async {
//     try {
//       final response = await _dio.post(
//         '/recommendations/products/lists/',
//         data: {
//           'occasion': occasion,
//           'price': priceRange,
//         },
//         options: Options(headers: {
//           'Content-Type': 'application/json',
//         }),
//       );

//       if (response.statusCode == 200) {
//         final data = response.data;
//         final gifts = data['data']?['gifts'];

//         if (gifts is List) {
//           _recommendations =
//               gifts.map((e) => GiftRecommendation.fromJson(e)).toList();
//         } else {
//           _recommendations = [];
//         }
//       } else {
//         print('Failed to fetch gifts: HTTP ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching gift recommendations: $e');
//     }
//     notifyListeners();
//   }

//   Future<GiftRecommendation> fetchGiftRecommendation({
//     required String userName,
//     required String occasion,
//     required String priceRange,
//     List<ResponseFormItem>? responseFormData,
//   }) async {
//     try {
//       final response = await _dio.post(
//         '/recommendations/single/product/',
//         data: {
//           'user_data': {
//             'user_name': userName,
//             'occasion': occasion,
//             'price_range': priceRange,
//             'response_form_data':
//                 responseFormData?.map((e) => e.toJson()).toList(),
//           }
//         },
//         options: Options(headers: {
//           'Content-Type': 'application/json',
//         }),
//       );

//       if (response.statusCode == 200) {
//         final data = response.data;
//         final gift = data['data']?['gift'];

//         if (gift != null) {
//           return GiftRecommendation.fromJson(gift);
//         } else {
//           throw Exception('Gift data not found in response');
//         }
//       } else {
//         throw Exception('Failed to fetch gift recommendation');
//       }
//     } catch (e) {
//       print('Error fetching gift recommendation: $e');
//       rethrow;
//     }
//   }

//   Future<String?> createGiftPot({
//     required String productName,
//     required String productImage,
//     required String productDescription,
//     required String amount,
//     required String productWebsiteLink,
//   }) async {
//     try {
//       final response = await _dio.post(
//         '/giftpot/create/',
//         data: {
//           "product_image": productImage,
//           "product_name": productName,
//           "product_describtion": productDescription,
//           "amount": amount,
//           "product_website_link": productWebsiteLink,
//         },
//         options: Options(headers: {
//           'Content-Type': 'application/json',
//         }),
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final data = response.data;
//         return data['gift_pot_id'] as String?;
//       } else {
//         throw Exception('Failed to create gift pot: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error creating gift pot: $e');
//       return null;
//     }
//   }

//   Future<void> fetchNotifications() async {
//     try {
//       final response = await _dio.get(
//         '/upcoming-notes/',
//         options: Options(headers: {
//           'Content-Type': 'application/json',
//         }),
//       );

//       if (response.statusCode == 200) {
//         final data = response.data;

//         if (data is List) {
//           _notes = data.map((e) => Note.fromJson(e)).toList();
//           print('✅ Notes fetched: $_notes');
//         } else {
//           print('❌ Expected list but got: $data');
//         }
//       } else {
//         print('❌ Failed to fetch notes. Status: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('❌ Notes fetch error: $e');
//     }

//     notifyListeners();
//   }

//   Future<void> createNote({required String noteDate, required String note}) async {
//   print('🟡 createNote called with date: $noteDate and note: $note'); // 🔍

//   try {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('authToken') ?? '';
//     print('🪪 Token used: $token'); // 🔍

//     final response = await _dio.post(
//       '/user-note/',
//       data: {
//         'note_date': noteDate,
//         'note': note,
//       },
//       options: Options(
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       ),
//     );

//     print('📥 Status code: ${response.statusCode}');
//     print('📥 Response: ${response.data}');

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print('✅ Note created: ${response.data['message']}');
//     } else {
//       print('⚠️ Note creation failed. Status: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('❌ Error creating note: $e');
//   }
// }

// }


//...................auth_service.dart...................//
// class AuthService {
//   final Dio _dio;
//   final String baseUrl;

//   AuthService({
//     required Dio dio,
//     required this.baseUrl,
//   }) : _dio = dio;

//   Options _formOptions() => Options(contentType: Headers.formUrlEncodedContentType);

//   void _logError(String tag, dynamic error) {
//     print('[$tag] Error: $error');
//     if (error is DioException && error.response != null) {
//       print('[$tag] Response: ${error.response?.data}');
//     }
//   }

//   //================== LOGIN ==================
//   Future<Usermodel?> login(String email, String password) async {
//     try {
//       final response = await _dio.post(
//         '/login/',
//         data: {'email': email, 'password': password},
//         options: _formOptions(),
//       );

//       if (response.statusCode == 200) {
//         final data = response.data;
//         print('Login Response: $data');

//         if (data['user'] != null && data['message'] == "Login successful") {
//           return Usermodel.fromJson(data['user']);
//         }
//         print('Login failed: ${data['message']}');
//       }
//     } catch (e) {
//       _logError('LOGIN', e);
//     }
//     return null;
//   }

//   //================== SIGN UP ==================
//   Future<Usermodel?> registration(String name, String email, int phone, String password) async {
//     try {
//       final response = await _dio.post(
//         '/sign-up/',
//         data: {
//           'full_name': name,
//           'email': email,
//           'mobile': phone.toString(),
//           'password': password,
//         },
//         options: _formOptions(),
//       );

//       print('Signup Response: ${response.data}');

//       if (response.statusCode == 201) {
//         return Usermodel(
//           full_name: name,
//           email: email,
//           mobile: phone,
//           address: '',
//           age: 0,
//           status: 'Active',
//           image: '',
//         );
//       }
//       throw Exception(response.data['message'] ?? 'Signup failed');
//     } catch (e) {
//       _logError('SIGNUP', e);
//       return null;
//     }
//   }

//   //================== SEND OTP ==================
//   Future<bool> sendOtp(String email) async {
//     try {
//       final response = await _dio.post(
//         '/send-otp/',
//         data: {'email': email},
//         options: _formOptions(),
//       );

//       if (response.statusCode == 200 && response.data['success'] == true) {
//         return true;
//       }
//       print('Send OTP failed: ${response.data['message']}');
//     } catch (e) {
//       _logError('SEND OTP', e);
//     }
//     return false;
//   }

//   //================== VERIFY OTP ==================
//   Future<bool> verifyOtp(String email, String otp) async {
//     try {
//       final response = await _dio.post(
//         '/verify-otp/',
//         data: {'email': email.trim(), 'otp': otp.trim()},
//         options: _formOptions(),
//       );

//       if (response.statusCode == 200) {
//         final message = response.data['message']?.toString().toLowerCase() ?? '';
//         return message.contains('verified');
//       }
//     } catch (e) {
//       _logError('VERIFY OTP', e);
//     }
//     return false;
//   }

//   //================== RESET PASSWORD (FORGOT) ==================
//   Future<bool> resetPassword({
//     required String email,
//     required String otp,
//     required String newPassword,
//   }) async {
//     try {
//       final response = await _dio.post(
//         '/reset-password/',
//         data: {
//           'email': email.trim(),
//           'otp': otp.trim(),
//           'new_password': newPassword.trim(),
//         },
//         options: _formOptions(),
//       );

//       if (response.statusCode == 200 &&
//           response.data['message'].toString().toLowerCase().contains('reset')) {
//         return true;
//       }

//       print('⚠️ Reset Password failed: ${response.data}');
//     } catch (e) {
//       _logError('RESET PASSWORD', e);
//     }
//     return false;
//   }

//   //================== CHANGE PASSWORD (LOGGED IN USER) ==================
//   Future<bool> changeOldPassword({
//     required String oldPassword,
//     required String newPassword1,
//     required String newPassword2,
//   }) async {
//     print('Changing password...');

//     try {
//       final response = await _dio.put(
//         '/update-password/',
//         data: {
//           'old_password': oldPassword,
//           'new_password1': newPassword1,
//           'new_password2': newPassword2,
//         },
//         // Content-Type is set globally. Authorization is also already in Dio.
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//           },
//         ),
//       );

//       print('Change Password Response: ${response.data}');
//       return response.statusCode == 200;
//     } catch (e) {
//       _logError('CHANGE PASSWORD', e);
//       return false;
//     }
//   }
// }
