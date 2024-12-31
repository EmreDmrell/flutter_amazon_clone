import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/custom_button.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/features/admin/services/admin_services.dart';
import 'package:flutter_amazon_clone/features/search/screens/search_screen.dart';
import 'package:flutter_amazon_clone/models/order/order.dart';
import 'package:flutter_amazon_clone/models/user/user.dart';
import 'package:flutter_amazon_clone/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class OrderDetailScreen extends StatefulWidget {
  static const String routeName = '/order-detail';
  final Order order;
  const OrderDetailScreen({super.key, required this.order});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int currentStep = 0;
  final AdminServices adminServices = AdminServices();

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  // Only for admin (status change)

  void updateOrderStatus(int status) async {
    adminServices.updateOrderStatus(
      context: context,
      order: widget.order,
      status: status +1,
    );
    setState(() {
      currentStep += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
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
                            borderSide: const BorderSide(
                                color: Colors.black38, width: 1),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'View Order Details',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order Date:       ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt))}'),
                      Text('Order ID:           ${widget.order.id}'),
                      Text('Total Price:        ${widget.order.totalPrice}'),
                    ],
                  ),
                ),
                const Text(
                  'Purchase Details',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                    child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.order.products.length,
                    itemBuilder: (context, index) {
                      final product = widget.order.products[index];
                      return ListTile(
                      leading: Image.network(product.images[0]),
                      title: Text(product.name),
                      subtitle: Text('Price: ${product.price}'),
                      trailing: Text('Quantity: ${widget.order.quantity[index]}'),
                      );
                    },
                    ),
                ),
                const Text(
                'Tracking',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (context, details) {
                    if (user.type == 'admin') {
                      return CustomButton(
                        text: 'Done',
                        onTap: () => updateOrderStatus(details.currentStep),
                      );
                    }
                    return const SizedBox();
                  },
                  steps: [
                    Step(
                      title: const Text('Pending'),
                      content: const Text(
                        'Your order is yet to be delivered',
                      ),
                      isActive: currentStep > 0,
                      state: currentStep > 0
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Completed'),
                      content: const Text(
                        'Your order has been delivered, you are yet to sign.',
                      ),
                      isActive: currentStep > 1,
                      state: currentStep > 1
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Received'),
                      content: const Text(
                        'Your order has been delivered and signed by you.',
                      ),
                      isActive: currentStep > 2,
                      state: currentStep > 2
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Delivered'),
                      content: const Text(
                        'Your order has been delivered and signed by you!',
                      ),
                      isActive: currentStep >= 3,
                      state: currentStep >= 3
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                  ],
                ),
              ),
              ],
            ),
          ),
        ));
  }
}
