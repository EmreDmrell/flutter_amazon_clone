import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/custom_button.dart';
import 'package:flutter_amazon_clone/features/address/screen/address_screen.dart';
import 'package:flutter_amazon_clone/features/cart/widgets/cart_product.dart';
import 'package:flutter_amazon_clone/features/cart/widgets/cart_subtotal.dart';
import 'package:flutter_amazon_clone/features/home/widgets/address_box.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';
import '../../../providers/user_provider.dart';
import '../../search/screens/search_screen.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = "/cart";
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void navigateToAddressScreen(int totalAmount) {
    Navigator.pushNamed(context, AddressScreen.routeName, arguments: totalAmount.toString());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    int sum = 0;
    user.cart.map((e) => sum += e.quantity * e.product.price).toList();
    
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      //I don't understand how it passes the query
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () => {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: const BorderSide(color: Colors.black38, width: 1),
                        ),
                        hintText: 'Type for searching',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                )),
                Container(
                  color: Colors.transparent,
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.mic,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          )),
      body: Column(
        spacing: 15,
        children: [
          const AddressBox(),
          const CartSubtotal(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CustomButton(
              text: ('Proceed to Buy (${user.cart.length} item)'),
              onTap: () => navigateToAddressScreen(sum),
              color: Colors.yellow[600],
            ),
          ),
          Container(
            color: Colors.black12.withValues(
              blue: (0.08),
            ),
            height: 1,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: user.cart.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CartProduct(index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
