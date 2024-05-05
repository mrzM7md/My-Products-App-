import 'package:equatable/equatable.dart';
import 'package:products/core/network/usecases/base_usecase.dart';
import 'package:products/products/domain/entities/Product.dart';
import 'package:products/products/domain/repository/base_products_repository.dart';

class GetAllUserProductsUseCase implements BaseUseCase<List<Product>? ,GetAllUserProductsParameters>{
  final BaseProductsRepository baseProductsRepository;

  GetAllUserProductsUseCase({required this.baseProductsRepository});

  @override
  Future<List<Product>> call({required GetAllUserProductsParameters parameters}) async {
    return await baseProductsRepository.getAllUserProducts(userId: parameters.userId);
  }

}

class GetAllUserProductsParameters extends Equatable {
  final int userId;

  const GetAllUserProductsParameters({required this.userId});

  @override
  List<Object?> get props => [userId];
}