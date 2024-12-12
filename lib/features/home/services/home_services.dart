import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/models/product/product.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/config.dart';
import '../../../constants/errorHandling.dart';
import '../../../constants/utils.dart';
import '../../../providers/product_provider.dart';
import '../../../providers/user_provider.dart';

class HomeServices {
  Future<void> fetchCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    context.read<ProductProvider>().resetProductList();
    try {
      http.Response res = await http.get(
        Uri.parse('$homeIpAddress/api/products?category=$category'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
      );

      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              context.read<ProductProvider>().addProduct(
                    Product.fromJson(
                      jsonDecode(res.body)[i],
                    ),
                  );
            }
          },
        );
      }
    } catch (e) {
      if (context.mounted) showSnackBar(context, e.toString());
    }
  }

  Future<void> fetchDealOfDay({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    context.read<ProductProvider>().resetProductList();
    try {
      http.Response res = await http.get(
        Uri.parse('$homeIpAddress/api/deal-of-day'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
      );

      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            context.read<ProductProvider>().changeDealOfDay(
                  Product.fromJson(
                    jsonDecode(res.body),
                  ),
                );
          },
        );
      }
    } catch (e) {
      if (context.mounted) showSnackBar(context, e.toString());
    }
  }
}
