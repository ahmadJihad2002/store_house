import 'dart:io';

class UserParams {
  final String name;
  final File image;
  final String email;
  final String password;

  UserParams({
    required this.name,
    required this.image,
    required this.email,
    required this.password,
  });
}
