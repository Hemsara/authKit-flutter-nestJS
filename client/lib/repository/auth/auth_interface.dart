import 'package:client/models/dto/login.dto.dart';

abstract class AuthInterface {
  Future<bool> login(LoginDTO dto);
}
