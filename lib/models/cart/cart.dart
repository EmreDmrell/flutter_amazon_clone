import 'package:json_annotation/json_annotation.dart';

import '../product/product.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  final List<Product> product;
  final int quantity;

  //rating

  Cart({
    required this.product,
    required this.quantity,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}
