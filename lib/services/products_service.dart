import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:login/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:login/services/auth_service.dart';

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-course-313c8-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  late Product selectedProduct;
  late AuthService authService;

  final storage = new FlutterSecureStorage();
  File? newFile;
  bool isLoading = false;
  bool isSaving = false;
  notifyListeners();

  ProductsService() {
    this.loadProducts();
  }
  Future<List<Product>> loadProducts() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'products.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final resp = await http.get(url);
    final Map<String, dynamic> productsMap = json.decode(resp.body);
    if (productsMap.containsKey('error')) {
      print('logout');
      storage.delete(key: 'token');
    } else {
      productsMap.forEach((key, value) {
        final tempProduct = Product.fromMap(value);
        tempProduct.id = key;
        this.products.add(tempProduct);
      });
      isLoading = false;
      notifyListeners();
    }
    return this.products;
  }

  Future saveorCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      await this.createProduct(product);
    } else {
      await this.updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final resp = await http.put(url, body: product.toJson());

    final decodeData = resp.body;

    final index =
        this.products.indexWhere((element) => element.id == product.id);
    this.products[index] = product;

    return product.id!;
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final resp = await http.post(url, body: product.toJson());

    final decodeData = json.decode(resp.body);
    print(decodeData);
    product.id = decodeData['name'];
    this.products.add(product);

    return product.id!;
  }

  void updateSelectedProductImage(String path) {
    this.selectedProduct.picture = path;
    this.newFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (this.newFile == null) return null;
    this.isSaving = true;
    notifyListeners();

    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/crsoft/image/upload?upload_preset=nmctcqdk');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', newFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();

    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print(resp.body);
      return null;
    }
    final decodeData = json.decode(resp.body);
    return decodeData['secure_url'];
  }
}
