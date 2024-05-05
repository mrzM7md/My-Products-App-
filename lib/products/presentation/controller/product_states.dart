import 'package:equatable/equatable.dart';
import 'package:products/products/domain/entities/Product.dart';
import 'package:products/products/domain/entities/product_response.dart';

abstract class ProductState{}

class InitialProductState extends Equatable implements ProductState{
  @override
  List<Object?> get props => [];
}

class GetAllProductsState extends Equatable implements ProductState{
  final List<Product> products;

  const GetAllProductsState({required this.products});

  @override
  List<Object?> get props => [products];
}

class AddUpdateDeleteProductState extends Equatable implements ProductState{
  final ProductResponse productResponse;
  const AddUpdateDeleteProductState({required this.productResponse});

  @override
  List<Object?> get props => [productResponse];

}

class ChangeProductImageState implements ProductState{}