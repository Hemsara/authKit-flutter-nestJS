import 'package:client/models/dto/dto.dart';

class RegisterDTO extends DTO {
  String email;
  String firstName;
  String lastName;
  String password;

  RegisterDTO({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
    };
  }
}
