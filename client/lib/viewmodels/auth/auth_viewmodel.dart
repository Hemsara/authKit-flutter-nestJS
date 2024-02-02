import 'package:client/api/api_service.dart';
import 'package:client/api/models/api/error.dart';
import 'package:client/models/dto/auth/login.dto.dart';
import 'package:client/models/dto/auth/register.dto.dart';
import 'package:client/models/dto/auth/token_response.dart';
import 'package:client/repository/auth/auth_repository.dart';
import 'package:client/res/storage.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository(ApiService());

  bool _loginIn = false;
  bool _registering = false;

  String _error = "Login failed. Please check your credentials.";
  String _registeringError = "Registering failed";

  bool get loginIn => _loginIn;
  bool get registering => _registering;

  String get error => _error;
  String get registeringError => _registeringError;

  Future<bool> loginWith(LoginDTO dto) async {
    try {
      _loginIn = true;
      notifyListeners();

      TokenResponse token = await _authRepository.login(dto);
      await SecureStorageHelper().delete("token");
      await SecureStorageHelper().write("token", token.accessToken);

      _loginIn = false;

      notifyListeners();
      return true;
    } on ApiError catch (err) {
      _error = err.message;
      return false;
    } catch (e) {
      _error = 'An unexpected error occurred. Please try again later.';
      return false;
    } finally {
      _loginIn = false;
      notifyListeners();
    }
  }

  Future<bool> registerUserWith(RegisterDTO dto) async {
    try {
      _registering = true;
      notifyListeners();

      final success = await _authRepository.register(dto);
      _registering = false;
      notifyListeners();
      return success;
    } on ApiError catch (err) {
      _registeringError = err.message;
      return false;
    } catch (e) {
      _registeringError =
          'An unexpected error occurred. Please try again later.';
      return false;
    } finally {
      _registering = false;
      notifyListeners();
    }
  }
}
