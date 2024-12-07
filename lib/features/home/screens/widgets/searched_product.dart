import 'package:flutter/material.dart';

import '../../../../models/product/product.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;

  const SearchedProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        children: [
          Image.network(
            product.images[0],
            fit: BoxFit.fitHeight,
            width: 135,
          )
        ],
      ),
    );
  }
}
