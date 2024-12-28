// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['_id'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e['product'] as Map<String, dynamic>))
          .toList(),
      quantity: (json['products'] as List<dynamic>)
          .map((e) => (e['quantity'] as num).toInt())
          .toList(),
      address: json['address'] as String,
      userId: json['userId'] as String,
      orderedAt: (json['orderedAt'] as num).toInt(),
      status: (json['status'] as num).toInt(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      '_id': instance.id,
      'products': instance.products,
      'quantity': instance.quantity,
      'address': instance.address,
      'userId': instance.userId,
      'orderedAt': instance.orderedAt,
      'status': instance.status,
      'totalPrice': instance.totalPrice,
    };
