import 'package:client/api/api_service.dart';
import 'package:client/api/endpoints.dart';
import 'package:client/api/models/api/response.dart';
import 'package:client/models/dto/auth/login.dto.dart';
import 'package:client/models/dto/auth/register.dto.dart';
import 'package:client/repository/auth/auth_interface.dart';

import '../../models/dto/auth/token_response.dart';

class AuthRepository extends AuthInterface {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  @override
  Future<TokenResponse> login(LoginDTO dto) async {
    try {
      ApiResponse response = await _apiService.post(
        navigateToLogin: false,
        data: dto,
        endpoint: EndPoints.login,
      );
      return TokenResponse(accessToken: response.data['access_token']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> register(RegisterDTO dto) async {
    try {
      ApiResponse response = await _apiService.post(
        data: dto,
        endpoint: EndPoints.register,
      );
      return response.status == RequestStatus.success;
    } catch (e) {
      rethrow;
    }
  }
}
