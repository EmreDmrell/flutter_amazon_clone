import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../constants/config.dart';
import '../../../constants/errorHandling.dart';
import '../../../constants/utils.dart';
import '../../../models/product/product.dart';
import '../../../providers/product_provider.dart';
import '../../../providers/user_provider.dart';

class SearchServices {
  Future<void> fetchSearchedProducts({
    required BuildContext context,
    required String searchQuery,
  }) async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    context.read<ProductProvider>().resetProductList();
    try {
      http.Response res = await http.get(
        Uri.parse('$homeIpAddress/api/products/search/$searchQuery'),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'x-auth-token': userProvider.user.token},
      );

      if(context.mounted){
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
      if(context.mounted) showSnackBar(context, e.toString());
    }
  }
}