import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/config.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:flutter_amazon_clone/providers/product_provider.dart';
import 'package:flutter_amazon_clone/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../constants/errorHandling.dart';
import '../../../models/product/product.dart';

class ProductDetailServices {
  void rateProduct(
      {required BuildContext context,
      required Product product,
      required double rating}) async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try{
      http.Response res = await http.post(
        Uri.parse('$homeIpAddress/api/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id' : product.id,
          'rating' : rating,
        })
      );

      if(context.mounted){
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            context.read<ProductProvider>().rateProduct(product, rating, userProvider.user.id);
          },
        );
      }
    }catch(e){
      if(context.mounted){
        showSnackBar(context, e.toString());
      }
    }
  }
}
