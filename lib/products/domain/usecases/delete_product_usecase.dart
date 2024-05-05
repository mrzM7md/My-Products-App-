import 'package:equatable/equatable.dart';
import 'package:products/core/network/usecases/base_usecase.dart';
import 'package:products/products/domain/entities/product_response.dart';
import 'package:products/products/domain/repository/base_products_repository.dart';

class DeleteProductUseCase implements BaseUseCase<ProductResponse, DeleteNewProductParameters> {
  final BaseProductsRepository baseProductsRepository;

  DeleteProductUseCase({required this.baseProductsRepository});

  @override
  Future<ProductResponse> call({required DeleteNewProductParameters parameters}) async {
    return await baseProductsRepository.deleteProduct(userId: parameters.userId, productId: parameters.productId, imageName: parameters.imageName);
  }

}

class DeleteNewProductParameters extends Equatable{
  final int userId;
  final int productId;
  final String imageName;

  const DeleteNewProductParameters({required this.userId, required this.productId, required this.imageName});

  @override
  List<Object?> get props => [userId, productId, imageName];
}