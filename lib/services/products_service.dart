import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:login/models/product.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-course-313c8-default-rtdb.firebaseio.com';

  final List<Product> products = [];

  late Product selectedProduct;

  bool isLoading = true;
  bool isSaving = true;
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

  Future saveorCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
    } else {
      await this.updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    final resp = await http.put(url, body: product.toJson());

    final decodeData = resp.body;

    //TODO actualizar producto

    final index =
        this.products.indexWhere((element) => element.id == product.id);
    this.products[index] = product;

    return product.id!;
  }
}
