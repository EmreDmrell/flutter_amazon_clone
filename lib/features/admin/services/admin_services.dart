import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/config.dart';
import 'package:flutter_amazon_clone/constants/errorHandling.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter_amazon_clone/models/product/product.dart';
import 'package:flutter_amazon_clone/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required int price,
    required int quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic(CLOUD_NAME, UPLOAD_PRESET);
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        category: category,
        images: imageUrls,
      );

      http.Response res = await http.post(
        Uri.parse('$homeIpAddress/admin/add-product'),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'x-auth-token': userProvider.user.token},
        body: jsonEncode(product.toJson()),
      );
      httpErrorHandling (
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Product added successfully');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$homeIpAddress/admin/get-products'),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'x-auth-token': userProvider.user.token},
      );

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonDecode(res.body)[i],
              ),
            );
          }
        },
      );

    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }
}
