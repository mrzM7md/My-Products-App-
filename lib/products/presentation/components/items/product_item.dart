import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:products/core/network/api_constance.dart';
import 'package:products/products/domain/entities/Product.dart';
import 'package:products/products/presentation/controller/product_cubit.dart';
import 'package:products/products/presentation/screens/product_creaxt_update_screen.dart';

class ProductItem extends StatelessWidget {
  final Product productModel;
  const ProductItem({required this.productModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsetsDirectional.all(5),
    child: Column(
      children: [
        Row(
          children: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx) => ProductCreateUpdateScreen(product: productModel)));
            }, icon: const Icon(Icons.edit)),
            IconButton(onPressed: (){
              ProductCubit.get(context).deleteProduct(product: productModel);
            }, icon: const Icon(Icons.close)),
          ],
        ),
        ConditionalBuilder(
            condition: productModel.image.isNotEmpty,
            builder: (ctx) => Image.network(width: 250, height: 250, ApiConstance.httpLinkImage(imageName: productModel.image)),
            fallback: (ctx)=> Container()),
        Text(productModel.title),
        Text(productModel.description),
        Text(productModel.price.toString()),
      ],
    ),);
  }
}
