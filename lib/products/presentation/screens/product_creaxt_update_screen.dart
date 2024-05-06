import 'dart:ffi';
import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:products/core/constants/componnets.dart';
import 'package:products/core/local/cache_helper.dart';
import 'package:products/core/network/api_constance.dart';
import 'package:products/core/utilities/enums.dart';
import 'package:products/products/domain/entities/Product.dart';
import 'package:products/products/presentation/controller/product_cubit.dart';
import 'package:products/products/presentation/controller/product_states.dart';

class ProductCreateUpdateScreen extends StatefulWidget {
  final Product product;

  const ProductCreateUpdateScreen({required this.product, super.key});

  @override
  State<ProductCreateUpdateScreen> createState() =>
      _ProductCreateUpdateScreenState(product: product);
}

class _ProductCreateUpdateScreenState extends State<ProductCreateUpdateScreen> {
  final Product product;
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late GlobalKey<ScaffoldState> _scaffoldKey;

  File? _imageFile;

  _ProductCreateUpdateScreenState({required this.product}) {
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _priceController = TextEditingController();
    _scaffoldKey = GlobalKey<ScaffoldState>();

    _nameController.text = product.title;
    _descriptionController.text = product.description;
    _priceController.text = product.price.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text(product.title.isEmpty ? "No Name" : product.title)),
      body: Padding(
        padding: const EdgeInsetsDirectional.all(6),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MaterialButton(
                color: Colors.black,
                onPressed: () {
                  _scaffoldKey.currentState!.showBottomSheet(
                       (ctx) {
                        return Row(
                          children: [
                            Expanded(
                              child: MaterialButton(
                                onPressed: () async {
                                  await ImagePicker()
                                      .pickImage(source: ImageSource.camera).then((xFile) {
                                    if(xFile != null){
                                      _imageFile = File(xFile.path);
                                      ProductCubit.get(context).callChangeProductImage();
                                    }
                                  });
                                },
                                height: 120.0,
                                child: const Icon(
                                  Icons.camera_alt_rounded,
                                ),
                              ),
                            ),
                            Expanded(
                              child: MaterialButton(
                                onPressed: () async {
                                  await ImagePicker()
                                      .pickImage(source: ImageSource.gallery).then((xFile) {
                                    if(xFile != null){
                                      _imageFile = File(xFile.path);
                                      ProductCubit.get(context).callChangeProductImage();
                                    }
                                  });
                                },
                                height: 120.0,
                                child: const Icon(
                                  Icons.image,
                                ),
                              ),
                            )
                          ],
                        );
                      }
                  );
                },
                child: const Text(
                  "Add image",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              BlocBuilder<ProductCubit, ProductState>(
                buildWhen: (prev, current) => current is ChangeProductImageState,
                builder: (context, state) {
                  return ConditionalBuilder(
                    condition: _imageFile != null || product.image.isNotEmpty ,
                    builder: (ctx) =>
                    _imageFile != null ? Image.file(
                      _imageFile!,
                      width: 50,
                      height: 50,
                    ) :
                    Image.network(
                      ApiConstance.httpLinkImage(imageName: product.image),
                      width: 50,
                      height: 50,
                    ),
                    fallback: (ctx) => Container(),
                  );
                },
              ),
              Text("Product Name"),
              TextField(
                controller: _nameController,
              ),
              Text("Product Description"),
              TextField(
                controller: _descriptionController,
              ),
              Text("Product Price"),
              TextField(
                controller: _priceController,
              ),
              MaterialButton(
                color: Colors.black,
                onPressed: () {
                  product.id == -1 ? ProductCubit.get(context).addNewProduct(
                    imageFile: _imageFile,
                    product: getProduct(),
                  ) : ProductCubit.get(context).updateProduct(
                      imageFile: _imageFile,
                      product: getProduct(),
                  );
                  Navigator.pop(context);
                },
                child: Text(
                  product.id == -1 ? "GO" : "Update",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Product getProduct(){
    return Product(
            id: product.id,
            title: _nameController.text,
            description: _descriptionController.text,
            price: double.parse(_priceController.text),
            image: product.image,
            userId: CacheHelper.getInt(key: "user_id")
    );
  }

}
