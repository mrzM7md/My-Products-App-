import 'dart:io';

import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class ApiConstance {
  static const String httpServerLink = "http://10.0.2.2:1234/products_api";

  static const String httpLinkSignUp = '$httpServerLink/auth/signup.php';
  static const String httpLinkLogin = '$httpServerLink/auth/login.php';

  static const String httpLinkAddNewProduct = '$httpServerLink/products/add.php';
  static const String httpLinkUpdateProduct = '$httpServerLink/products/edit.php';

  static String httpLinkDeleteProduct({required int userId, required int productId, required String imageName}) => '$httpServerLink/products/delete.php?user_id=$userId&id=$productId&image=$imageName';
  static String httpLinkGetUserProducts({required int userId}) => '$httpServerLink/products/view.php?user_id=$userId';

  static String httpLinkImage({required imageName}) => '$httpServerLink/assets/images/$imageName';


  static Future<http.Response> postRequest({
    required String url,
    required Map<String, dynamic> data
  }) async {
    return await http.post(
        Uri.parse(url), body: data
    );
  }


  static Future<http.Response> getRequest({required String url}) async {
    http.Response response = await http.get(
      Uri.parse(url),
    );
    return response;
  }

  static Future<http.Response> postRequestWithFile({required String url,required Map data, required File file}
      ) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multipartFile = http.MultipartFile("image", stream, length,
        filename: basename(file.path));
    request.files.add(multipartFile);
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myRequest = await request.send();

    var response = await http.Response.fromStream(myRequest);

    return response;
  }

}
