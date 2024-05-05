import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:products/core/network/usecases/base_usecase.dart';
import 'package:products/products/domain/entities/Product.dart';
import 'package:products/products/domain/entities/product_response.dart';
import 'package:products/products/domain/repository/base_products_repository.dart';

class UpdateProductUseCase implements BaseUseCase<ProductResponse, UpdateProductParameters> {
  final BaseProductsRepository baseProductsRepository;

  UpdateProductUseCase({required this.baseProductsRepository});

  @override
  Future<ProductResponse> call({required UpdateProductParameters parameters}) async {
    return await baseProductsRepository.updateProduct(imageFile: parameters.imageFile, product: parameters.product);
  }

}

class UpdateProductParameters extends Equatable{
  final File? imageFile;
  final Product product;
  const UpdateProductParameters({required this.imageFile, required this.product});
  @override
  List<Object?> get props => [imageFile, product];
}