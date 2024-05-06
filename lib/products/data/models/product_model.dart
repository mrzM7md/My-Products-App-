import 'package:products/products/domain/entities/Product.dart';

class ProductModel extends Product {
  const ProductModel(
      {
        required super.id,
        required super.title,
        required super.description,
        required super.price,
        required super.image,
        required super.userId
      });

  factory ProductModel.fromJson(Map json) {
    return ProductModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        price: double.parse(json['price'].toString()),
        image: json['image'],
        userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id": "$id",
      "title": title,
      "description": description,
      "price": "$price",
      "user_id": "$userId",
      'last_image_name': image,
    };
  }
}
