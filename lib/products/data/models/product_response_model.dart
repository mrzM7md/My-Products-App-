import 'package:products/core/utilities/enums.dart';

import '../../domain/entities/product_response.dart';

class ProductResponseModel extends ProductResponse{
  const ProductResponseModel({required super.message, required super.responseProductStatus});

  factory ProductResponseModel.fromJson({required Map json}){
    ResponseProductStatus responseProductStatus;
    switch(json["status"]){
      case "success":
        responseProductStatus = ResponseProductStatus.success;
        break;
      case "fail-file":
        responseProductStatus = ResponseProductStatus.failFile;
        break;
      case "fail":
        responseProductStatus = ResponseProductStatus.fail;
        break;
      default:
        responseProductStatus = ResponseProductStatus.error;
    }
    return ProductResponseModel(
      message: json["message"],
      responseProductStatus: responseProductStatus,
    );
  }
}