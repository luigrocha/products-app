import 'package:flutter/material.dart';
import 'package:login/screens/screens.dart';
import 'package:login/services/services.dart';
import 'package:login/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    if (productsService.isLoading) return LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          child: ProductCard(
            product: productsService.products[index],
          ),
          onTap: () {
            productsService.selectedProduct =
                productsService.products[index].copy();
            Navigator.pushNamed(context, 'product');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}
