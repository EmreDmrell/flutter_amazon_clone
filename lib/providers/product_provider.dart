import 'package:flutter_amazon_clone/models/product/product.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _productList = [];

  List<Product> get productList => _productList;

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
}