import 'package:flutter_amazon_clone/models/product/product.dart';
import 'package:flutter/material.dart';
import '../models/rating/rating.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> _productList = [];

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

  void rateProduct(Product product, rating, String userId){
    int index = _productList.indexOf(product);
    bool haveIBeenRated = false;
    for(int i = 0; i < product.ratings!.length ; i++){
      if(product.ratings![i].userId == userId){
        _productList[index].ratings![i].rating == rating;
        haveIBeenRated = true;
      }
    }

    if(!haveIBeenRated){
      _productList[index].ratings!.add(Rating(userId: userId, rating: rating));
    }
    debugPrint(_productList[index].ratings!.toString());
    notifyListeners();
  }
}