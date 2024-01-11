import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:client/api/base_api_service.dart';
import 'package:client/api/endpoints.dart';
import 'package:client/api/models/api/error.dart';
import 'package:client/api/models/api/response.dart';
import 'package:client/models/dto/dto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService extends BaseApiService {
  // Send an HTTP request and handle the response
  Future<ApiResponse> _sendRequest(
      {required String method,
      required String endpoint,
      required bool mustAuthenticated,
      DTO? data,
      bool shouldNavigate = true}) async {
    try {
      var url = Uri.parse("${EndPoints.baseURL}$endpoint");

      var request = http.Request(method, url)
        ..headers.addAll(await getHeaders(mustAuthenticated));

      if (data != null) {
        request.body = jsonEncode(data.toMap());
      }

      http.StreamedResponse response = await request.send();
      var resData = await response.stream.bytesToString();
      dynamic responseData = jsonDecode(resData);
      // Debugging output for request and response
      log("=======");
      log("🗣️ Sending $method request to $url");
      log("🗣️ Sending data ${data ?? data!.toMap()}");
      log("🗣️ Status code: ${response.statusCode}");
      log("🗣️ Body: $resData");
      log("=======");

      handleUnAuthenticated(response.statusCode, shouldNavigate);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          status: RequestStatus.success,
          data: jsonDecode(resData),
        );
      }

      // Failed response
      throw ApiError(
          message: responseData['message'].runtimeType == List
              ? (responseData['message'] as List).first
              : responseData['message']);
    } on SocketException {
      // Handle network connectivity errors
      throw ApiError(message: "Unable to connect to the server");
    } on TimeoutException {
      // Handle request timeout
      throw ApiError(message: 'The request is timed out');
    } catch (e) {
      // Handle other errors
      debugPrint('An error thrown : $e');
      if (e.runtimeType == ApiError) {
        rethrow;
      }
      throw ApiError(message: "Something went wrong");
    }
  }

  // GET Request
  Future<ApiResponse> get({
    required String endpoint,
    required bool mustAuthenticated,
    DTO? data,
    bool shouldNavigate = true,
  }) async {
    return _sendRequest(
      method: "GET",
      endpoint: endpoint,
      data: data,
      mustAuthenticated: mustAuthenticated,
    );
  }

  // PUT Request
  Future<ApiResponse> put(
      {required DTO data,
      bool shouldNavigate = true,
      required String endpoint,
      required bool mustAuthenticated}) async {
    return _sendRequest(
      method: "PUT",
      endpoint: endpoint,
      data: data,
      mustAuthenticated: mustAuthenticated,
    );
  }

  // DELETE Request
  Future<ApiResponse> delete(
      {required DTO data,
      required String endpoint,
      required bool mustAuthenticated}) async {
    return _sendRequest(
      method: "DELETE",
      endpoint: endpoint,
      data: data,
      mustAuthenticated: mustAuthenticated,
    );
  }

  // POST Request
  Future<ApiResponse> post(
      {required DTO data,
      required String endpoint,
      String? baseURL,
      bool? isProtected}) async {
    return _sendRequest(
      method: "POST",
      endpoint: endpoint,
      data: data,
      mustAuthenticated: isProtected ?? true,
    );
  }
}
