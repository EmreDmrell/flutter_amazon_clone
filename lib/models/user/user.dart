import 'package:json_annotation/json_annotation.dart';

import '../cart/cart.dart';


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
  final List<Cart> cart;

  User({required this.id, required this.name, required this.email, required this.password, required this.address, required this.type, required this.token, required this.cart});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    String? type,
    String? token,
    List<Cart>? cart,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      cart: cart ?? this.cart,
    );
  }
}