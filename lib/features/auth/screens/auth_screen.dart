import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/custom_button.dart';
import 'package:flutter_amazon_clone/common/widgets/custom_text_field.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/features/auth/services/auth_service.dart';

import '../../../common/widgets/password_text_field.dart';

enum Auth { signIn, signUp }

class AuthScreen extends StatefulWidget {
  static const String routeName = "/auth-screen";

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signIn;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void signUpUser() {
    authService.signUpUser(context: context, email: _emailController.text, password: _passwordController.text, name: _nameController.text);
  }

  void signInUser() {
    authService.signInUser(context: context,email: _emailController.text, password: _passwordController.text,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                ),
                ListTile(
                  tileColor: _auth == Auth.signUp ? GlobalVariables.backgroundColor : GlobalVariables.greyBackgroundCOlor,
                  title: const Text(
                    "Create Account",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signUp,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signUp)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                        key: _signUpFormKey,
                        child: Column(
                          children: [
                            CustomTextField(controller: _nameController, hintText: 'Name', keyboardType: TextInputType.text, icon: const Icon(Icons.account_circle_outlined, size: 24,),),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(controller: _emailController, hintText: 'e-Mail', keyboardType: TextInputType.emailAddress,icon : const Icon(Icons.email_outlined, size: 24,)),
                            const SizedBox(
                              height: 10,
                            ),
                            PasswordTextField(controller: _passwordController, hintText: 'Password',keyboardType: TextInputType.visiblePassword,),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomButton(
                              text: 'Sign Up',
                              onTap: () {
                                if (_signUpFormKey.currentState!.validate()) {
                                  signUpUser();
                                }
                              },
                            )
                          ],
                        )),
                  ),
                ListTile(
                  tileColor: _auth == Auth.signIn ? GlobalVariables.backgroundColor : GlobalVariables.greyBackgroundCOlor,
                  title: const Text(
                    "Sign In",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signIn,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if(_auth == Auth.signIn)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _signInFormKey,
                      child: Column(
                        children: [
                          CustomTextField(controller: _emailController, hintText: 'e-Mail', keyboardType: TextInputType.emailAddress, icon:  const Icon(Icons.email_outlined, size: 24,),),
                          const SizedBox(height: 10,),
                          PasswordTextField(controller: _passwordController, hintText: 'Password', keyboardType: TextInputType.visiblePassword,),
                          const SizedBox(height: 10,),
                          CustomButton(
                              text: 'Sign In',
                              onTap: () {
                                if(_signInFormKey.currentState!.validate()){
                                  signInUser();
                                }
                              })
                        ],
                      ),),
                  )
              ],
            ),
          )),
    );
  }
}
