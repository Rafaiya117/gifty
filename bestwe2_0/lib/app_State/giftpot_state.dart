import 'dart:convert';

import 'package:bestwe2_0/app_State/token_manager.dart';
import 'package:bestwe2_0/model/giftpod.dart';
import 'package:bestwe2_0/model/noteModel.dart';
import 'package:bestwe2_0/model/notification.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GiftpotState extends ChangeNotifier {
  final Dio _dio;
  final String _apiKey;

  GiftpotState(this._dio, this._apiKey);

  List<GiftPot> _giftList = [];
  List<GiftPot> get giftList => _giftList;

  List<GiftRecommendation> _recommendations = [];
  List<GiftRecommendation> get recommendations => _recommendations;

  List<Note> _note = [];
  List<Note> get note => _note;

   List<UserNotification> _notification = [];
  List<UserNotification> get notification => _notification;

  // Add these fields for tracking user selections and answers
  String? selectedOccasion;
  String? selectedPriceRange;
  final List<ResponseFormItem> responseFormAnswers = [];

  // Optionally, helper methods to set/clear them:
  void setOccasionAndPrice({required String occasion, required String priceRange}) {
    selectedOccasion = occasion;
    selectedPriceRange = priceRange;
    responseFormAnswers.clear();
    notifyListeners();
  }

  void addResponseFormAnswer(ResponseFormItem item) {
    responseFormAnswers.add(item);
    notifyListeners();
  }

  void clearResponseFormAnswers() {
    responseFormAnswers.clear();
    notifyListeners();
  }

  Future<void> fetchGifts() async {
    try {
      final response = await _dio.get(
        '/giftpots/',
        options: Options(headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json'
        }),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data is List) {
          _giftList = data.map((e) => GiftPot.fromJson(e)).toList();
        }
      }
    } catch (e) {
      print('Gift fetch error: $e');
    }
    notifyListeners();
  }

  Future<void> fetchGiftRecommendationsData({required String occasion,required String priceRange,}) async {
  try {
    final response = await _dio.post(
      '/recommendations/products/lists/',
      data: {'occasion': occasion,'price': priceRange,},
      options: Options(headers: {'Authorization': 'Bearer $_apiKey','Content-Type': 'application/json',}),);

    if (response.statusCode == 200) {
      final data = response.data;
      print(response.data);
      final gifts = data['data']?['gifts'];
      print('DEBUG: gifts from API = $gifts'); // 🔍 Debug print
      if (gifts is List) {
        _recommendations = gifts.map((e) => GiftRecommendation.fromJson(e)).toList();
      } else {
        _recommendations = [];
      }
    } else {
      print('Failed to fetch gifts: HTTP ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching gift recommendations: $e');
  }
  notifyListeners();
}

  Future<GiftRecommendation> fetchGiftRecommendation({required String userName, required String occasion, required String priceRange, List<ResponseFormItem>? responseFormData,}) async {
  try {
    final response = await _dio.post(
      '/recommendations/single/product/',
      data: {
        'user_data': {
          'user_name': userName,
          'occasion': occasion,
          'price_range': priceRange,
          'response_form_data': responseFormData?.map((e) => e.toJson()).toList(),
        }
      },
      options: Options(headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      }),
    );

    if (response.statusCode == 200) {
      final data = response.data;
      final gift = data['data']?['gift'];
      if (gift != null) {
        return GiftRecommendation.fromJson(gift);
      } else {
        throw Exception('Gift data not found in response');
      }
    } else {
      throw Exception('Failed to fetch gift recommendation');
    }
  } catch (e) {
    print('Error fetching gift recommendation: $e');
    rethrow;
  }
}

Future<String?> createGiftPot({required String productName, required String productImage, required String productDescription, required String amount, required String productWebsiteLink,}) async {
  try {
    final response = await _dio.post(
      '/giftpot/create/', // Replace with your actual endpoint
      data: {
        "product_image": productImage,
        "product_name": productName,
        "product_describtion": productDescription,
        "amount": amount,
        "product_website_link": productWebsiteLink,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = response.data;
      return data['gift_pot_id'] as String?;
    } else {
      throw Exception('Failed to create gift pot: ${response.statusCode}');
    }
  } catch (e) {
    print('Error creating gift pot: $e');
    return null;
  }
}

  Future<void> fetchNotifications() async {
    try {
      final token = await TokenManager.getToken();

      if (token == null) {
        print('❌ No token found. User might not be logged in.');
        return;
      }
      print('❌ .................................$token');
      final response = await _dio.get(
        '/upcoming-notes/',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is List) {
         _notification = data.map((e) => UserNotification.fromJson(e)).toList();
          print('✅ notification fetched: $_notification');
        } else {
          print('❌ Expected list but got: $data');
        }
      } else {
        print('❌ Failed to fetch notification. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ notification fetch error: $e');
    }

    notifyListeners();
  }

  Future<void> createNote({required String noteDate, required String note}) async {
  print('🟡 createNote called with date: $noteDate and note: $note'); // 🔍

  try {
    final token =  await TokenManager.getToken();
    print('🪪 Token used: $token'); // 🔍

    final response = await _dio.post(
      '/user-note/',
      data: {
        'note_date': noteDate,
        'note': note,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );

    print('📥 Status code: ${response.statusCode}');
    print('📥 Response: ${response.data}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('✅ Note created: ${response.data['message']}');
    } else {
      print('⚠️ Note creation failed. Status: ${response.statusCode}');
    }
  } catch (e) {
    print('❌ Error creating note: $e');
  }
}

  Future<void> fetchNotes() async {
    try {
      final token = await TokenManager.getToken();
      final response = await _dio.get('/user-note/retrieve/', options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ));

      if (response.statusCode == 200 && response.data is List) {
        _note = (response.data as List).map((e) => Note.fromJson(e)).toList();
        notifyListeners();
      }
    } catch (e) {
      print("❌ Error fetching notes: $e");
    }
  }

}