import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/errorHandling.dart';
import 'package:flutter_amazon_clone/constants/ip_adresses.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:flutter_amazon_clone/models/User/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = new User('', name, email, password, '', '', '');

      http.Response response = await http.post(
        Uri.parse('http://$homeIpAdress:3000/api/signup'),
        body: jsonEncode(user.toJson()) ,
        headers: <String, String>{
          'Content-Type' : 'application/json; charset=UTF-8'
        },
      );

      httpErrorHandling(response: response, context: context, onSuccess: () {
        showSnackBar(context, "Account created! You can now sign in with same credentials");
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
