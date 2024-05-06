import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products/core/constants/componnets.dart';
import 'package:products/core/utilities/enums.dart';
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
    ProductCubit.get(context).callUserProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Products"),),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (ctx) => sl<ProductCreateUpdateScreen>()));
          },
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<ProductCubit, ProductState>(
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
        builder: (context, state) {
          if(state is GetAllProductsState){
            return ConditionalBuilder(
                condition: state.products.isNotEmpty,
                builder: (ctx) => ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ProductItem(productModel: state.products[index]);
                  },
                ),
                fallback: (ctx) => const Center(child: Text("Empty")),
            );
          }
          return const Center(child: CircularProgressIndicator());
        }, ),
    );
  }
}
