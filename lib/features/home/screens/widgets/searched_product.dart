import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/stars.dart';
import 'package:flutter_amazon_clone/features/product_details/screens/product_details_screen.dart';

import '../../../../models/product/product.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;

  const SearchedProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {

    void navigateToSearchScreen() {
      Navigator.pushNamed(context, ProductDetailsScreen.routeName, arguments: product);
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: navigateToSearchScreen,
            child: Image.network(
              product.images[0],
              fit: BoxFit.fitWidth,
              width: 135,
            ),
          ),
          Column(
            children: [
              Container(
                width: 235,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  product.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  maxLines: 2,
                ),
              ),
              Container(
                width: 235,
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: const Stars(
                  rating: 3,
                ),
              ),
              Container(
                width: 235,
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  '\$${product.price}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                ),
              ),
              Container(
                width: 235,
                padding: const EdgeInsets.only(left: 10,),
                child: const Text(
                  'Eligible for FREE Shipping',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  maxLines: 1,
                ),
              ),
              Container(
                width: 235,
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: const  Text(
                  'In Stock',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.teal
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
