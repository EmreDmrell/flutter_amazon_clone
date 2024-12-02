import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/single_product.dart';
import 'package:flutter_amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:flutter_amazon_clone/features/admin/services/admin_services.dart';

import '../../../common/widgets/loader.dart';
import '../../../models/product/product.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? productList;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }


  fetchAllProducts() async {
    productList = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return productList == null
        ? const Loader()
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: productList!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (context, index) {
                  var productData = productList![index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 140,
                        width: double.infinity,
                        child: SingleProduct(imageSrc: productData.images[0]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Text(
                              productData.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          IconButton(onPressed: () {}, icon: const Icon(Icons.delete_outline_rounded))
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: navigateToAddProduct,
              tooltip: 'Add a Product',
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          );
  }
}
