import 'package:flutter_amazon_clone/models/product/product.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> _productList = [];
  Product? _dealOfDay = Product(name: '', description: '', price: 0, quantity: 0, category: '', images: []);

  List<Product> get productList => _productList;

  Product get dealOfDay => _dealOfDay!;

  void resetProductList(){
    _productList.clear();
  }

  void addProduct(Product product) async{
    _productList.add(product);
    notifyListeners();
  }

  void deleteProduct(int index) async{
    _productList.removeAt(index);
    notifyListeners();
  }

  void changeDealOfDay(Product product){
    _dealOfDay = product;
    notifyListeners();
  }
}