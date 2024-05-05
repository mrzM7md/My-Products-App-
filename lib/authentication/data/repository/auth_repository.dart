import 'dart:convert';

import 'package:products/authentication/data/datasource/auth_datasource.dart';
import 'package:products/authentication/data/models/auth_response_model.dart';
import 'package:products/authentication/domain/entities/auth.dart';
import 'package:products/authentication/domain/entities/auth_response.dart';
import 'package:products/authentication/domain/repository/base_auth_repository.dart';
import 'package:products/core/utilities/enums.dart';

class AuthRepository implements BaseAuthRepository{
  BaseAuthDataSource baseAuthDataSource;

  AuthRepository({required this.baseAuthDataSource});

  @override
  Future<AuthResponse> login({required Auth auth}) {
    return baseAuthDataSource.login(auth: auth).then((response) {
      AuthResponseModel authResponse;

      var jsonData = jsonDecode(response.body);
      jsonData["message"] = "success login";

      authResponse = AuthResponseModel.fromJson(jsonData);

      if(response.statusCode == 200){
        if(authResponse.statue == ResponseAuthStatus.fail){
          jsonData["message"] = "incorrect info";
        }
      }
      else {
        jsonData["message"] = "check your internet connection";
      }

      authResponse = AuthResponseModel.fromJson(jsonData);
      return authResponse;
    });
  }

  @override
  Future<AuthResponse> registerNewAccount({required Auth auth}) {
    return baseAuthDataSource.registerNewAccount(auth: auth).then((response) {
      AuthResponseModel authResponse;

      var jsonData = jsonDecode(response.body);
      jsonData["message"] = "successful";

      authResponse = AuthResponseModel.fromJson(jsonData);

      if(response.statusCode == 200){

        if(authResponse.statue == ResponseAuthStatus.fail){
          jsonData["message"] = "email or username used";
        }
      }
      else {
        jsonData["message"] = "check your internet connection";
      }

      authResponse = AuthResponseModel.fromJson(jsonData);
      return authResponse;
    });
  }

}