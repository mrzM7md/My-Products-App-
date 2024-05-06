import 'dart:io';

import 'package:http/http.dart';
import 'package:products/core/network/api_constance.dart';
import 'package:products/products/data/models/product_model.dart';
import 'package:products/products/domain/entities/Product.dart';

abstract class BaseProductsDatasource {
  Future<Response> getAllUserProducts({required int userId});

  Future<Response> addNewProduct({required File? imageFile, required Product product});

  Future<Response> updateProduct({required File? imageFile, required Product product});

  Future<Response> deleteProduct(
      {
        required int userId,
        required int productId,
        required String imageName
      });
}

class ProductsDatasource implements BaseProductsDatasource {
  @override
  Future<Response> getAllUserProducts({required int userId}) async {
    return await ApiConstance.getRequest(
        url: ApiConstance.httpLinkGetUserProducts(userId: userId),
    );
  }

  @override
  Future<Response> addNewProduct({required File? imageFile, required Product product}) async {
    if(imageFile != null){
      return await ApiConstance.postRequestWithFile(
          url: ApiConstance.httpLinkAddNewProduct,
          data: _convertProductModelToJson(product: product),
          file:imageFile,
      );
    }
    return await ApiConstance.postRequest(
      url: ApiConstance.httpLinkAddNewProduct,
      data: _convertProductModelToJson(product: product),);
  }

  @override
  Future<Response> deleteProduct({required int userId, required int productId, required String imageName}) async {
    return await ApiConstance.getRequest(
        url: ApiConstance.httpLinkDeleteProduct(userId: userId, productId: productId, imageName: imageName));
  }

  @override
  Future<Response> updateProduct({required File? imageFile, required Product product}) async {
    if(imageFile != null){
      return await ApiConstance.postRequestWithFile(
        url: ApiConstance.httpLinkUpdateProduct,
        data: _convertProductModelToJson(product: product), file:imageFile,
      );
    }
    return await ApiConstance.postRequest(
      url: ApiConstance.httpLinkUpdateProduct,
      data: _convertProductModelToJson(product: product),);
  }

  Map<String, dynamic> _convertProductModelToJson({required Product product}) {
    print("image: " + product.image);
    return ProductModel(
        id: product.id,
        title: product.title,
        description: product.description,
        price: product.price,
        image: product.image,
        userId: product.userId,
    ).toJson();
  }
}