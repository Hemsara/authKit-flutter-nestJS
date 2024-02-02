import 'dart:async';

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
}
