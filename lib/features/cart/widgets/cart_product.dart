import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/cart/services/cart_services.dart';
import 'package:flutter_amazon_clone/features/product_details/services/product_details_services.dart';
import 'package:flutter_amazon_clone/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/cart/cart.dart';
import '../../../models/product/product.dart';
import '../../product_details/screens/product_details_screen.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {

  final ProductDetailServices productDetailServices = ProductDetailServices();
  final CartServices cartServices = CartServices();

  void increaseQuantity(Product product){
    productDetailServices.addToCart(context: context, product: product);
  }
  void decreaseQuantity(Product product){
    cartServices.removeFromCart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final Cart productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = productCart.product;
    final quantity = productCart.quantity;

    void navigateToSearchScreen() {
      Navigator.pushNamed(context, ProductDetailsScreen.routeName,
          arguments: product);
    }
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          Row(
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
                    padding: const EdgeInsets.only(left: 10),
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
                    child: const Text(
                      'In Stock',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16, color: Colors.teal),
                      maxLines: 1,
                    ),
                  ),
                ],
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black12,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: IconButton(onPressed: () => decreaseQuantity(product), icon: const Icon(Icons.remove,size: 18,)),
                      ),
                      Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: Text(quantity.toString()),
                      ),
                      Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: IconButton(onPressed: () => increaseQuantity(product), icon: const Icon(Icons.add,size: 18,)),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
