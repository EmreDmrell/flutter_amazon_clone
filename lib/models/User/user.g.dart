// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['_id'] as String,
      json['name'] as String,
      json['email'] as String,
      json['password'] as String,
      json['address'] as String,
      json['type'] as String,
      json['token'] as String,
      //json['cart'] as List<dynamic>
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'password' : instance.password,
      'address': instance.address,
      'type': instance.type,
      'token': instance.token,
      //'cart' : instance.cart
    };
