// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
      userId: json['userId'] as String,
      rating: (json['rating'] as num).toDouble(),
    );

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'userId': instance.userId,
      'rating': instance.rating,
    };
