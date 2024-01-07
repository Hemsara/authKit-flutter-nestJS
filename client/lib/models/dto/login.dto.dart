import 'package:client/models/dto/dto.dart';

class LoginDTO extends DTO {
  final String email;
  final String password;
  LoginDTO({
    required this.email,
    required this.password,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}
