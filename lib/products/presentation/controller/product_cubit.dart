import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products/core/local/cache_helper.dart';
import 'package:products/core/utilities/enums.dart';
import 'package:products/products/domain/entities/Product.dart';
import 'package:products/products/domain/entities/product_response.dart';
import 'package:products/products/domain/usecases/add_new_product_usecase.dart';
import 'package:products/products/domain/usecases/delete_product_usecase.dart';
import 'package:products/products/domain/usecases/get_all_user_products_usecase.dart';
import 'package:products/products/domain/usecases/update_product_usecase.dart';
import 'package:products/products/presentation/controller/product_states.dart';

class ProductCubit extends Cubit<ProductState> {

  final GetAllUserProductsUseCase getAllUserProductsUseCase;
  final AddNewProductUseCase addNewProductUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  
  ProductCubit(
      {required this.getAllUserProductsUseCase,
        required this.addNewProductUseCase,
        required this.updateProductUseCase,
        required this.deleteProductUseCase,
      })
      : super(InitialProductState());

  static ProductCubit get(context) => BlocProvider.of(context);

  void callUserProducts(String keyWord) {
    int userId = CacheHelper.getInt(key: 'user_id');
    getAllUserProductsUseCase(parameters: GetAllUserProductsParameters(userId: userId)).then((products) {
      emit(GetAllProductsState(products: products.where((x) => x.title.toUpperCase().contains(keyWord.toUpperCase()) || x.description.toUpperCase().contains(keyWord.toUpperCase()) ).toList()));
    });
  }

  void addNewProduct({required File? imageFile, required Product product}){
    addNewProductUseCase(parameters: AddNewProductParameters(imageFile: imageFile, product: product)).then((response) {
      emit(AddUpdateDeleteProductState(productResponse: ProductResponse(message: response.message, responseProductStatus: response.responseProductStatus)));
      if(response.responseProductStatus == ResponseProductStatus.success){
        callUserProducts("");
      }
    });
  }

  void updateProduct({required File? imageFile, required Product product}) {
    updateProductUseCase(parameters: UpdateProductParameters(imageFile: imageFile, product: product)).then((response) {
      emit(AddUpdateDeleteProductState(productResponse: ProductResponse(message: response.message, responseProductStatus: response.responseProductStatus)));
      if(response.responseProductStatus == ResponseProductStatus.success){
        callUserProducts("");
      }
    });
    }

  void deleteProduct({required Product product}) {
    deleteProductUseCase(parameters: DeleteNewProductParameters(userId: product.userId, productId: product.id, imageName: product.image)).then((response) {
      emit(AddUpdateDeleteProductState(productResponse: ProductResponse(message: response.message, responseProductStatus: response.responseProductStatus)));
      if(response.responseProductStatus == ResponseProductStatus.success){
        callUserProducts("");
      }
    });
  }

    void callChangeProductImage(){
      emit(ChangeProductImageState());
    }

}