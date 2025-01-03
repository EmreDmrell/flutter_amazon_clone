import 'package:json_annotation/json_annotation.dart';

import '../rating/rating.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final String name;
  final String description;
  final int price;
  final int quantity;
  final String category;
  final List<String> images;
  final String? id;
  final List<Rating>? ratings;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.category,
    required this.images,
    this.id,
    this.ratings,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
