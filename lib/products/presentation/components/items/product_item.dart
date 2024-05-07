import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:products/core/network/api_constance.dart';
import 'package:products/products/domain/entities/Product.dart';
import 'package:products/products/presentation/components/widgets/build_button.dart';
import 'package:products/products/presentation/controller/product_cubit.dart';
import 'package:products/products/presentation/screens/product_creaxt_update_screen.dart';

import '../../../../core/constants/componnets.dart';

class ProductItem extends StatelessWidget {
  final Product productModel;
  const ProductItem({required this.productModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsetsDirectional.all(5),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10),
        color: Colors.black12,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                  BuildButton(
                    icon: Icons.close,
                    onTap: (){
                      ProductCubit.get(context).deleteProduct(product: productModel);
                    },
                  ),
            const Divider(color: Colors.black,),
            ConditionalBuilder(
                condition: productModel.image.isNotEmpty,
                builder: (ctx) => Container(
                    child: Card(
                      color: Colors.white,
                        child: Container(
                          padding: const EdgeInsetsDirectional.all(10),
                            child: Image.network(width: double.infinity, height: 200, ApiConstance.httpLinkImage(imageName: productModel.image), fit: BoxFit.fill,))),
                ),
                fallback: (ctx)=> Container()
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildText(text: productModel.title, fontSize: 22, maxLines: 1,  isBold: true),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildText(text: productModel.description, fontSize: 18, maxLines: 3, isBold: false),
            ),
            const SizedBox(height: 10,),
            const Divider(color: Colors.black,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildText(text: "${productModel.price}\$", fontSize: 18, maxLines: 3, isBold: true),
                ),
                const Spacer(),
                BuildButton(
                  icon: Icons.edit,
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) => ProductCreateUpdateScreen(product: productModel)));
                  },
                  )
              ],
            ),
          ],
        ),
      ),
    ),
    );
  }

}
