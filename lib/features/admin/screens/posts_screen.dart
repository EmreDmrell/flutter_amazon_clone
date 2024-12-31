import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/single_product.dart';
import 'package:flutter_amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:flutter_amazon_clone/features/admin/services/admin_services.dart';
import 'package:flutter_amazon_clone/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/loader.dart';
import '../../../constants/utils.dart';
import '../../../models/product/product.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }


  fetchAllProducts() async{
    await adminServices.fetchAllProducts(context: context);
  }

  void deleteProduct(Product product, int index){
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: (){
        showSnackBar(context, "Product deleted successfully");
        context.read<ProductProvider>().deleteProduct(index);
      }
    );
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    List<Product> productList = context.watch<ProductProvider>().productList;
    return productList.isEmpty
        ? const Loader()
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: productList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (context, index) {
                  var productData = productList[index];
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
                          IconButton(onPressed: () => deleteProduct(productData, index), icon: const Icon(Icons.delete_outline_rounded))
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              shape: const CircleBorder(eccentricity: 0.5),
              onPressed: navigateToAddProduct,
              tooltip: 'Add a Product',
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
          );
  }
}
