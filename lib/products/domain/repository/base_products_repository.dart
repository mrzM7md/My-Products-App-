import 'dart:io';

import 'package:products/products/domain/entities/Product.dart';
import 'package:products/products/domain/entities/product_response.dart';

abstract class BaseProductsRepository {
  Future<List<Product>> getAllUserProducts({required int userId});

  Future<ProductResponse> addNewProduct({required File? imageFile, required Product product});

  Future<ProductResponse> updateProduct({required File? imageFile, required Product product});

  Future<ProductResponse> deleteProduct(
      {
        required int userId,
        required int productId,
        required String imageName
      });
}
