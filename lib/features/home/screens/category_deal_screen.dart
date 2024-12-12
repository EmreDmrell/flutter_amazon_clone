import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/single_product.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';
import '../../../models/product/product.dart';
import '../../../providers/product_provider.dart';
import '../../product_details/screens/product_details_screen.dart';
import '../services/home_services.dart';

class CategoryDealScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;

  const CategoryDealScreen({super.key, required this.category});

  @override
  State<CategoryDealScreen> createState() => _CategoryDealScreenState();
}

class _CategoryDealScreenState extends State<CategoryDealScreen> {
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    await homeServices.fetchCategoryProducts(
        context: context, category: widget.category);
  }

  @override
  Widget build(BuildContext context) {
    void navigateToProductDetailsScreen(Product product) {
      Navigator.pushNamed(context, ProductDetailsScreen.routeName, arguments: product);
    }
    List<Product> productList = context.watch<ProductProvider>().productList;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.topLeft,
            child: Text(
              'Keep shopping for ${widget.category}',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 180,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(8),
              itemCount: productList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.4,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => navigateToProductDetailsScreen(productList[index]),
                  child: Column(
                    children: [
                      SingleProduct(imageSrc: productList[index].images[0]),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(
                          left: 0,
                          top: 5,
                          right: 15,
                        ),
                        child:Text(
                          productList[index].name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
