import 'package:client/models/dto/auth/login.dto.dart';
import 'package:client/models/dto/auth/register.dto.dart';

import '../../models/dto/auth/token_response.dart';

abstract class AuthInterface {
  Future<TokenResponse> login(LoginDTO dto);
  Future<bool> register(RegisterDTO dto);
}
