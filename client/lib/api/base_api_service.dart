import 'dart:async';

import 'package:client/api/models/api/error.dart';
import 'package:client/res/navigator.dart';
import 'package:client/views/login/screens/login_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BaseApiService {
  Future<Map<String, String>> getHeaders(bool mustAuthenticated) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (mustAuthenticated) {
      try {
        // Retrieve the authentication token from secure storage
        const storage = FlutterSecureStorage();
        String? token = await storage.read(key: 'token');
        headers['Authorization'] = 'Bearer $token';
      } catch (e) {
        return headers;
      }
    }
    return headers;
  }

  void handleUnAuthenticated(statusCode, shouldNavigate) {
    if (statusCode == 401) {
      if (shouldNavigate) {
        NavigatorHelper.replaceAll(const LoginScreen());
      } else {
        throw ApiError(
          message: 'Unauthorized',
        );
      }
    }
  }
}
