import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:login/models/product.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-course-313c8-default-rtdb.firebaseio.com';

  final List<Product> products = [];

  late Product selectedProduct;

  bool isLoading = true;
  notifyListeners();

  ProductsService() {
    this.loadProducts();
  }
//<List<Product>>
  Future<List<Product>> loadProducts() async {
    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);
    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      this.products.add(tempProduct);
    });
    isLoading = false;
    notifyListeners();
    return this.products;
  }
}
