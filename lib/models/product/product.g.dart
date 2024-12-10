// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      category: json['category'] as String,
      images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      id: json['_id'] as String?,
      ratings: (json['ratings'] as List<dynamic>?)
          ?.map((e) => Rating.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'quantity': instance.quantity,
      'category': instance.category,
      'images': instance.images,
      '_id': instance.id,
      'ratings': instance.ratings,
    };
