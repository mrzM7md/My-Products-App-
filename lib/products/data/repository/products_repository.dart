import 'dart:convert';
import 'dart:io';
import 'package:http/src/response.dart';
import 'package:products/products/data/datasource/products_datasource.dart';
import 'package:products/products/data/models/product_model.dart';
import 'package:products/products/data/models/product_response_model.dart';
import 'package:products/products/domain/entities/Product.dart';
import 'package:products/products/domain/entities/product_response.dart';
import 'package:products/products/domain/repository/base_products_repository.dart';

class ProductsRepository implements BaseProductsRepository {
  final BaseProductsDatasource baseProductsDatasource;
  ProductsRepository({required this.baseProductsDatasource});

  @override
  Future<ProductResponse> addNewProduct({required File? imageFile, required Product product}) {
    return baseProductsDatasource.addNewProduct(imageFile: imageFile, product: product).then((response) {
      return _getResponseResult(response: response);
    });
  }

  @override
  Future<ProductResponse> updateProduct({required File? imageFile, required Product product}) {
    return baseProductsDatasource.updateProduct(imageFile: imageFile, product: product).then((response) {
      return _getResponseResult(response: response);
    });  }

  @override
  Future<ProductResponse> deleteProduct({required int userId, required int productId, required String imageName}) {
    return baseProductsDatasource.deleteProduct(userId: userId, productId: productId, imageName: imageName).then((response) {
      return _getResponseResult(response: response);
    } );
  }

  @override
  Future<List<Product>> getAllUserProducts({required int userId}) async {
    List<Product> products = const [];
    await baseProductsDatasource.getAllUserProducts(userId: userId).then((response) {
      var jsonData = jsonDecode(response.body);
      if(response.statusCode == 200){
        if(jsonData['data'] != null){
          products = List<ProductModel>.from((jsonData['data'] as List).map((e) => ProductModel.fromJson(e) ) );
        }
      }
    });

    return products;
  }

  ProductResponseModel _getResponseResult({required Response response}) {
    var jsonData = jsonDecode(response.body);
    if(response.statusCode == 200) {
      print("status 200");
      return ProductResponseModel.fromJson(json: jsonData);
    }
    print("Another");
    return _getErrorResponseResult(jsonData: jsonData);
  }

  _getErrorResponseResult({required jsonData}){
    jsonData["message"] = "check your internet connection";
    jsonData["status"] = "error";
    return ProductResponseModel.fromJson(json: jsonData);
  }
}