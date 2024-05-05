import 'package:products/authentication/domain/entities/auth.dart';

class AuthModel extends Auth {
  const AuthModel({super.id, required super.name, required super.email, required super.password, required super.confirmPassword, required super.username});

  factory AuthModel.fromJson({required Map<String, dynamic> json}){
    return AuthModel(
        id: json['id'],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        confirmPassword: "",
        username: json["username"]
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "name": name,
      "email": email,
      "username": username,
      "password": password,
    };
  }

}