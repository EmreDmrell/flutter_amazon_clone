import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/errorHandling.dart';
import 'package:flutter_amazon_clone/constants/ip_addresses.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:flutter_amazon_clone/features/home/screens/home_screen.dart';
import 'package:flutter_amazon_clone/models/User/user.dart';
import 'package:flutter_amazon_clone/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User('', name, email, password, '', '', '');

      http.Response response = await http.post(
        Uri.parse('$homeIpAddress/api/signup'),
        body: jsonEncode(user.toJson()),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      );

      httpErrorHandling(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Account created! You can now sign in with same credentials");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$homeIpAddress/api/signin'),
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      );

      httpErrorHandling(
        response: response,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(response.body);
          await prefs.setString('x-auth-token', jsonDecode(response.body)['token']);
          
          Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth-token");

      if (token == null) {
        prefs.setString("x-auth-token", "");
      }

      var tokenRes = await http.post(
        Uri.parse('$homeIpAddress/tokenIsValid'),
        headers: <String, String > {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        }
      );

      var response = jsonDecode(tokenRes.body);

      if(response) {
        http.Response userRes = await http.get(
          Uri.parse('$homeIpAddress/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
