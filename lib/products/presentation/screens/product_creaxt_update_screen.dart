import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:products/core/constants/componnets.dart';
import 'package:products/core/local/cache_helper.dart';
import 'package:products/core/network/api_constance.dart';
import 'package:products/core/utilities/images.dart';
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
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          _scaffoldKey.currentState!.showBottomSheet((ctx) {
            return SizedBox(
              height: 180,
              child: Column(
                children: [
                  buildText(text: "Select an image", fontSize: 22, maxLines: 1, isBold: false),
                  Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          onPressed: () async {
                            await ImagePicker()
                                .pickImage(source: ImageSource.camera)
                                .then((xFile) {
                              if (xFile != null) {
                                _imageFile = File(xFile.path);
                                ProductCubit.get(context).callChangeProductImage();
                              }
                              Navigator.pop(context);
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
                                .pickImage(source: ImageSource.gallery)
                                .then((xFile) {
                              if (xFile != null) {
                                _imageFile = File(xFile.path);
                                ProductCubit.get(context).callChangeProductImage();
                              }
                              Navigator.pop(context);
                            });
                          },
                          height: 120.0,
                          child: const Icon(
                            Icons.image,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          });
        },
        backgroundColor: Colors.grey[300],
        shape: const CircleBorder(),
        child: const Icon(Icons.image),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 300,
            backgroundColor: Colors.black38,
            flexibleSpace: FlexibleSpaceBar(
                title: Text(product.title.isEmpty ? "No Name" : product.title),
                centerTitle: false,
                background: BlocBuilder<ProductCubit, ProductState>(
                    buildWhen: (prev, current) =>
                        current is ChangeProductImageState,
                    builder: (context, state) {
                      return ConditionalBuilder(
                        condition:
                            _imageFile != null || product.image.isNotEmpty,
                        builder: (ctx) => _imageFile != null
                            ? Image.file(
                                _imageFile!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.fill,
                              )
                            : Image.network(
                                fit: BoxFit.fill,
                                ApiConstance.httpLinkImage(
                                    imageName: product.image),
                                width: 50,
                                height: 50,
                              ),
                        fallback: (ctx) => Image.asset(
                          appLogoImage,
                          fit: BoxFit.contain,
                          width: 50,
                          height: 50,
                        ),
                      );
                    })),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        bottom: 10, top: 80),
                    child: buildText(
                        text: "Product Name",
                        fontSize: 18,
                        maxLines: 1,
                        isBold: true),
                  ),
                  appTextField(
                      controller: _nameController,
                      obscureText: false,
                      hintText: "product name here",
                      onChange: (value) {}),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        bottom: 10, top: 40),
                    child: buildText(
                        text: "Product Description",
                        fontSize: 18,
                        maxLines: 1,
                        isBold: true),
                  ),
                  appTextField(
                      controller: _descriptionController,
                      obscureText: false,
                      hintText: "product description here",
                      onChange: (value) {}),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        bottom: 10, top: 40),
                    child: buildText(
                        text: "Product Price",
                        fontSize: 18,
                        maxLines: 1,
                        isBold: true),
                  ),
                  appTextField(
                    keyboardType: TextInputType.number,
                      controller: _priceController,
                      obscureText: false,
                      hintText: "product name here",
                      onChange: (value) {}),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.only(top: 40, bottom: 240),
                    child: appButton(
                      onTap: () {
                        {
                          product.id == -1
                              ? ProductCubit.get(context).addNewProduct(
                                  imageFile: _imageFile,
                                  product: getProduct(),
                                )
                              : ProductCubit.get(context).updateProduct(
                                  imageFile: _imageFile,
                                  product: getProduct(),
                                );
                          Navigator.pop(context);
                        }
                      },
                      text: product.id == -1
                          ? "Add".toUpperCase()
                          : "Update".toUpperCase(),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Product getProduct() {
    return Product(
        id: product.id,
        title: _nameController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        image: product.image,
        userId: CacheHelper.getInt(key: "user_id"));
  }
}
