import 'package:products/authentication/data/models/auth_model.dart';

import 'package:products/authentication/domain/entities/auth_response.dart';
import 'package:products/core/utilities/enums.dart';

class AuthResponseModel extends AuthResponse {
  const AuthResponseModel({
    required super.statue,
    required super.message,
    required super.data,
  });

  factory AuthResponseModel.fromJson(Map json) {
    var data = json['data'];
    if(data == null){

    }
    return AuthResponseModel(
      statue: json["status"] == "success"
          ? ResponseAuthStatus.success
          : ResponseAuthStatus.fail,
      message: json["message"],
      data: json["status"] == "success" ? data != null ? AuthModel.fromJson(json: json['data']) : null : null,
    );
  }
}
