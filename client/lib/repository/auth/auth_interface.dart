import 'package:client/models/dto/auth/login.dto.dart';
import 'package:client/models/dto/auth/register.dto.dart';

abstract class AuthInterface {
  Future<bool> login(LoginDTO dto);
  Future<bool> register(RegisterDTO dto);
}
