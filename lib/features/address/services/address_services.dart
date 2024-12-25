import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/config.dart';
import 'package:flutter_amazon_clone/constants/errorHandling.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:flutter_amazon_clone/models/User/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter_amazon_clone/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class AddressServices {
  void saveUserAddress(
      {required BuildContext context, required String address}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final url = Uri.parse('$homeIpAddress/api/save-user-address');
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode({'address': address}));

      if (context.mounted) {
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              User user = userProvider.user
                  .copyWith(address: jsonDecode(response.body)['address']);
              userProvider.setUserFromModel(user);
            });
      }
    } catch (error) {
      if (context.mounted) {
        showSnackBar(context, error.toString());
      }
    }
  }

  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalAmount,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final url = Uri.parse('$homeIpAddress/api/order');
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode(
            {
              'cart': userProvider.user.cart,
              'address': address,
              'totalPrice': totalAmount,
            },
          ));

      if (context.mounted) {
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              showSnackBar(context, 'Order Placed Successfully');
              User user = userProvider.user.copyWith(cart: []);
              userProvider.setUserFromModel(user);
            });
      }
    } catch (error) {
      if (context.mounted) {
        showSnackBar(context, error.toString());
      }
    }
  }
}
