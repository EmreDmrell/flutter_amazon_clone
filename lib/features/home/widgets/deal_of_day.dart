import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/home/services/home_services.dart';
import 'package:flutter_amazon_clone/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/product/product.dart';
import '../../product_details/screens/product_details_screen.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  fetchDealOfDay() async {
    await homeServices.fetchDealOfDay(context: context);
  }

  @override
  Widget build(BuildContext context) {
    Product? product = context.watch<ProductProvider>().dealOfDay;

    void navigateToProductDetailsScreen(Product product) {
      Navigator.pushNamed(context, ProductDetailsScreen.routeName, arguments: product);
    }
    return product.name.isEmpty
        ? const SizedBox()
        : Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 10, top: 15),
              child: const Text(
                'Deal of the day',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => navigateToProductDetailsScreen(product),
              child: Image.network(
                product.images[0],
                height: 235,
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15),
              alignment: Alignment.topLeft,
              child: Text(
                '\$${product.price.toString()}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
              child: Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16)
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: product.images
                    .map((e) => Image.network(
                          e,
                          fit: BoxFit.fitWidth,
                          width: 100,
                          height: 100,
                        ))
                    .toList(),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ).copyWith(left: 15),
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed:() => navigateToProductDetailsScreen(product),
                child: Text(
                  'See all deals',
                  style: TextStyle(
                    color: Colors.cyan[800],
                  ),
                ),
              ),
            ),
          ],
        );
  }
}
