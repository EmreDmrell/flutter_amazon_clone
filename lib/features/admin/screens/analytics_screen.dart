import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/loader.dart';
import 'package:flutter_amazon_clone/features/admin/models/sales.dart';
import 'package:flutter_amazon_clone/features/admin/services/admin_services.dart';
import 'package:flutter_amazon_clone/features/admin/widgets/category_product_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  void getEarnings() async {
    final earningData = await adminServices.getEarnings(context: context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null 
    ? const Loader()
    : Column(
      children: [
        Text(
          'Total Sales: $totalSales',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        CategoryProductChart(earnings: earnings,),
      ],
    );
  }
}
