import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  final Dio _dio;

  UserServices({required Dio dio}) : _dio = dio;

  // JSON headers for APIs expecting application/json
  Options _jsonOptions({Map<String, String>? extraHeaders}) => Options(
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      ...?extraHeaders,
    },
  );

  // Form-encoded headers for form-based APIs
  Options _formOptions({Map<String, String>? extraHeaders}) => Options(
    contentType: 'multipart/form-data',
    headers: {
      ...?extraHeaders,
    },
  );

  /// Fetch list of models from the provided URL
  Future<List<T>> fetchAll<T>({required String url,required T Function(Map<String, dynamic>) fromJson, Options? options,}) async {
    try {
      final response = await _dio.get(url, options: options ?? _jsonOptions(),);

      final List data = response.data;
      print('FetchAll [$url] returned ${data.length} items');
      return data.map((e) => fromJson(e)).toList();

    } catch (e) {
      print('FetchAll error at [$url]: $e');
      rethrow;
    }
  }

  Future<T> fetchSingle<T>({required String url, required T Function(Map<String, dynamic>) fromJson, Options? options,}) async {
    try {
      final response = await _dio.get(url, options: options ?? _jsonOptions(),);

      final data = response.data;
      print('FetchSingle [$url] returned: $data');

      return fromJson(data);
    } catch (e) {
      print('FetchSingle error at [$url]: $e');
      rethrow;
    }
  }

  /// Submit a model using POST request
  Future<void> postdata<T>({required String url, required T model, required Map<String, dynamic> Function(T) toJson,}) async {
    try {
      final data = {'data': toJson(model)};

      final response = await _dio.post(url, data: data, options: _formOptions(),);
      print('PostData to [$url] successful with status ${response.statusCode}');
    } catch (e) {
      print('PostData error at [$url]: $e');
      rethrow;
    }
  }

  /// Update a model using custom method (POST/PUT) and optional wrapper

  Future<Map<String, dynamic>> updatedata<T>({required String url, required T model, required Map<String, dynamic> Function(T) toJson,
    bool wrapInData = false, String method = 'POST', File? imagefile,}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';

      final Map<String, dynamic> payload =
      wrapInData ? {'data': toJson(model)} : toJson(model);
      FormData formData = FormData.fromMap(payload);

      if (imagefile != null) {
        String filename = imagefile.path.split('/').last;
        formData.files.add(
          MapEntry(
            'image',
            await MultipartFile.fromFile(imagefile.path, filename: filename),
          ),
        );
      }

      final response = await _dio.request(
        url, data: formData,
        options: Options(
          method: method,
          headers: {
            'Authorization': 'Bearer $token', // ✅ Add token
            'Accept': 'application/json',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      print('✅ Update successful: ${response.data}');
      return response.data;
    } catch (e) {
      print('❌ Update error at [$url]: $e');
      throw e;
    }
  }


  /// Delete a record by optional ID using POST request
  Future<void> delete({required String url, String? id,}) async {
    try {
      final data = id != null ? {'id': id} : null;
      final response = await _dio.post(url, data: data, options: _formOptions(),);

      print('Delete successful at [$url]. Response: ${response.data}');
    } catch (e) {
      print('Delete error at [$url]: $e');
      rethrow;
    }
  }
}
