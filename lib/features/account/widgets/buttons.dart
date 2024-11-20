import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/features/account/widgets/account_button.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: "Your Orders", onTap: () =>{}),
            AccountButton(text: "Turn Seller", onTap: () =>{}),
          ],
        ),
        const SizedBox(height: 15,),
        Row(
          children: [
            AccountButton(text: "Log Out", onTap: () =>{}),
            AccountButton(text: "Your Wish List", onTap: () =>{}),
          ],
        ),
      ],
    );
  }
}
