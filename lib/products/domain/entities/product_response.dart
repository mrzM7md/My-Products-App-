import 'package:equatable/equatable.dart';
import 'package:products/core/utilities/enums.dart';

class ProductResponse extends Equatable {
  final String message;
  final ResponseProductStatus responseProductStatus;

  const ProductResponse({required this.message, required this.responseProductStatus});

  @override
  List<Object?> get props => [message, responseProductStatus];

}