
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/loader.dart';
import 'package:flutter_amazon_clone/common/widgets/single_product.dart';
import 'package:flutter_amazon_clone/features/admin/services/admin_services.dart';
import 'package:flutter_amazon_clone/features/order_details/screens/order_detail_screen.dart';
import 'package:flutter_amazon_clone/models/order/order.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  AdminServices adminServices = AdminServices();
  List<Order> orders = [];
  @override
  void initState() {
    super.initState();
    fetchAllOrders();
  }

  void fetchAllOrders() async {
    orders = await adminServices.fetchAllOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders.isEmpty
        ? const Loader()
        : Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              itemCount: orders.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final orderData = orders[index];
                return GestureDetector(
                  onTap: () {
                     Navigator.pushNamed(
                       context,
                       OrderDetailScreen.routeName,
                       arguments: orderData,
                     );
                  },
                  child: SingleProduct(
                      imageSrc: orderData.products[0].images[0]),
                );
              },
            ),
        );
  }
}
