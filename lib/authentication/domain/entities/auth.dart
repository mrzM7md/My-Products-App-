import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  final int? id;
  final String email;
  final String password;
  final String confirmPassword;
  final String username;
  final String name;

  const Auth(
      {this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.username});

  @override
  List<Object?> get props =>
      [id, name, email, password, confirmPassword, username];
}
