import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/account/widgets/buttons.dart';
import 'package:flutter_amazon_clone/features/account/widgets/name_bar.dart';
import 'package:flutter_amazon_clone/features/account/widgets/orders.dart';

import '../../../constants/global_variables.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  width: 250,
                  child: Image.asset(
                    'assets/images/amazon_in.png',
                    width: 120,
                    height: 45,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: IconButton(onPressed: () => {}, icon: const Icon(Icons.notifications_none_outlined)),
                      ),
                      IconButton(onPressed: () => {}, icon: const Icon(Icons.search_outlined))
                    ],
                  ),
                )
              ],
            ),
          )),
      body: const Column(
        children: [
          NameBar(),
          SizedBox(
            height: 15,
          ),
          TopButtons(),
          SizedBox(
            height: 10,
          ),
          Orders(),
        ],
      ),
    );
  }
}
