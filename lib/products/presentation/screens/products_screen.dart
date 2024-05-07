import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products/authentication/presentation/screens/login_screen.dart';
import 'package:products/core/constants/componnets.dart';
import 'package:products/core/local/cache_helper.dart';
import 'package:products/core/utilities/enums.dart';
import 'package:products/core/utilities/images.dart';
import 'package:products/products/presentation/components/items/product_item.dart';
import 'package:products/products/presentation/controller/product_cubit.dart';
import 'package:products/products/presentation/controller/product_states.dart';
import 'package:products/products/presentation/screens/product_creaxt_update_screen.dart';

import '../../../core/services/services_locator.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
 @override
  void initState() {
    super.initState();
    ProductCubit.get(context).callUserProducts("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Your Products"),
        leading: Padding(
          padding: const EdgeInsetsDirectional.all(10.0),
          child: Image.asset(appLogoImage),
        ),
        actions: [
          IconButton(onPressed: (){
            CacheHelper.setData(key: "user_id", value: -1);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => const LoginScreen()));
          }, icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButton: Container(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton.extended(
          backgroundColor: Colors.grey[300],
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (ctx) => sl<ProductCreateUpdateScreen>()));
            },
          label: const Row(children: [Text("New Product"), Icon(Icons.add)],),
        ),
      ),
      body: Column(
          children: [
            const SizedBox(height: 30,),
            appTextField(
              preIcon: const Icon(Icons.search),
              controller: TextEditingController(),
              obscureText: false,
              hintText: "Search by title or description",
              onChange: (value) {
                ProductCubit.get(context).callUserProducts(value.toString());
              }
            ),
            Expanded(
              child: BlocConsumer<ProductCubit, ProductState>(
                builder: (context, state) {
                  if(state is GetAllProductsState){
                    return ConditionalBuilder(
                      condition: state.products.isNotEmpty,
                      builder: (ctx) => ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsetsDirectional.only(top: 30),
                        itemCount: state.products.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 10),
                            child: ProductItem(productModel: state.products[index]),
                          );
                        },
                      ),
                      fallback: (ctx) => buildNoData(image: noDataImage, text: "no data to show"),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
                listener: (BuildContext context, ProductState state) {
                  if (state is AddUpdateDeleteProductState) {
                    Color textColor = Colors.redAccent;
                    if (state.productResponse.responseProductStatus ==
                        ResponseProductStatus.success) {
                      textColor = Colors.black;
                    }
                    getToast(
                        message: state.productResponse.message,
                        bkgColor: Colors.white,
                        textColor: textColor);
                  }
                },
                listenWhen: (prev, current) => current is AddUpdateDeleteProductState,
                buildWhen: (prev, current) => current is GetAllProductsState,
                ),
            ),
          ],
        ),
    );
  }
}
