import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:products/core/network/usecases/base_usecase.dart';
import 'package:products/products/domain/entities/Product.dart';
import 'package:products/products/domain/entities/product_response.dart';
import 'package:products/products/domain/repository/base_products_repository.dart';

class AddNewProductUseCase implements BaseUseCase<ProductResponse ,AddNewProductParameters> {
  final BaseProductsRepository baseProductsRepository;

  AddNewProductUseCase({required this.baseProductsRepository});

  @override
  Future<ProductResponse> call({required AddNewProductParameters parameters}) async {
    return await baseProductsRepository.addNewProduct(imageFile: parameters.imageFile, product: parameters.product);
  }

}

class AddNewProductParameters extends Equatable{
  final File? imageFile;
  final Product product;

  const AddNewProductParameters({required this.imageFile, required this.product});

  @override
  List<Object?> get props => [imageFile, product];
}