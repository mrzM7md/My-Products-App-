import 'package:http/http.dart';
import 'package:products/authentication/data/models/auth_model.dart';
import 'package:products/authentication/domain/entities/auth.dart';
import 'package:products/core/network/api_constance.dart';

abstract class BaseAuthDataSource{
  Future<Response> registerNewAccount({required Auth auth});
  Future<Response> login({required Auth auth});
}

class AuthDataSource implements BaseAuthDataSource {
  @override
  Future<Response> login({required Auth auth}) async {
    return await ApiConstance.postRequest(
        url: ApiConstance.httpLinkLogin,
        data: AuthModel(
            name: auth.name,
            email: auth.username,
            password: auth.password,
            confirmPassword: auth.confirmPassword,
            username: auth.username
       ).toJson());
  }

  @override
  Future<Response> registerNewAccount({required Auth auth}) async {
    return await ApiConstance.postRequest(
        url:  ApiConstance.httpLinkSignUp,
        data: AuthModel(
            name: auth.name,
            email: auth.email,
            password: auth.password,
            confirmPassword: auth.confirmPassword,
            username: auth.username
        ).toJson());
  }
}