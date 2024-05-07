import 'package:get_it/get_it.dart';
import 'package:products/authentication/data/datasource/auth_datasource.dart';
import 'package:products/authentication/data/repository/auth_repository.dart';
import 'package:products/authentication/domain/usecases/login_usecase.dart';
import 'package:products/authentication/domain/usecases/register_new_account_usecase.dart';
import 'package:products/authentication/presentation/controller/auth_cubit.dart';
import 'package:products/core/local/cache_helper.dart';
import 'package:products/products/data/datasource/products_datasource.dart';
import 'package:products/products/data/repository/products_repository.dart';
import 'package:products/products/domain/entities/Product.dart';
import 'package:products/products/domain/usecases/add_new_product_usecase.dart';
import 'package:products/products/domain/usecases/delete_product_usecase.dart';
import 'package:products/products/domain/usecases/get_all_user_products_usecase.dart';
import 'package:products/products/domain/usecases/update_product_usecase.dart';
import 'package:products/products/presentation/controller/product_cubit.dart';
import 'package:products/products/presentation/screens/product_creaxt_update_screen.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    //###################### Start Cubits ######################
    sl.registerFactory(() => AuthCubit(loginUseCase: sl<LoginUseCase>(), registerNewAccountUseCase: sl<RegisterNewAccountUseCase>()));
    sl.registerFactory(() => ProductCubit(
        getAllUserProductsUseCase: sl<GetAllUserProductsUseCase>(),
        addNewProductUseCase: sl<AddNewProductUseCase>(),
        updateProductUseCase: sl<UpdateProductUseCase>(),
        deleteProductUseCase: sl<DeleteProductUseCase>(),
    ));
    //###################### End Cubits ######################



    //###################### Start Auth ######################
    sl.registerLazySingleton(() => AuthDataSource());
    sl.registerLazySingleton(() => AuthRepository(baseAuthDataSource: sl<AuthDataSource>()));

    sl.registerLazySingleton(() => LoginUseCase(baseAuthRepository: sl<AuthRepository>()));
    sl.registerLazySingleton(() => RegisterNewAccountUseCase(baseAuthRepository: sl<AuthRepository>()));
    //###################### End Auth ######################

    //###################### Start Products ######################
    sl.registerLazySingleton(() => ProductCreateUpdateScreen(product: sl<Product>()));
    sl.registerLazySingleton(() => Product(id: -1, title: "", description: "", price: 0.0, image: "", userId: CacheHelper.getInt(key: "user_id")));

    sl.registerLazySingleton(() => ProductsDatasource());
    sl.registerLazySingleton(() => ProductsRepository(baseProductsDatasource: sl<ProductsDatasource>()));

    sl.registerLazySingleton(() => GetAllUserProductsUseCase(baseProductsRepository: sl<ProductsRepository>()));
    sl.registerLazySingleton(() => AddNewProductUseCase(baseProductsRepository: sl<ProductsRepository>()));
    sl.registerLazySingleton(() => UpdateProductUseCase(baseProductsRepository: sl<ProductsRepository>()));
    sl.registerLazySingleton(() => DeleteProductUseCase(baseProductsRepository: sl<ProductsRepository>()));
    //###################### End Products ######################


  }
}
