import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User{
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String token;

  User(this.id, this.name, this.email,this.password, this.address, this.type, this.token);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}