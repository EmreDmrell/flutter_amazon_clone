import 'package:flutter_amazon_clone/models/product/product.dart';
import 'package:json_annotation/json_annotation.dart';


part 'order.g.dart';

@JsonSerializable()
class Order {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final String address;
  final String userId;
  final int orderedAt;
  final int status;
  final double totalPrice;

  Order({
    required this.id,
    required this.products,
    required this.quantity,
    required this.address,
    required this.userId,
    required this.orderedAt,
    required this.status,
    required this.totalPrice,
  });

  factory Order.fromJson(Map<String, dynamic> json) =>
      _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
