import 'package:client/api/api_service.dart';
import 'package:client/api/models/api/error.dart';
import 'package:client/models/dto/login.dto.dart';
import 'package:client/repository/auth/auth_repository.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository(ApiService());

  bool _loading = false;
  String _error = "Login failed. Please check your credentials.";

  bool get loading => _loading;
  String get error => _error;

  Future<bool> login(LoginDTO dto) async {
    try {
      _loading = true;
      notifyListeners();

      final success = await _authRepository.login(dto);
      _loading = false;
      notifyListeners();
      return success;
    } on ApiError catch (err) {
      _error = err.message;
      return false;
    } catch (e) {
      _error = 'An unexpected error occurred. Please try again later.';
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
