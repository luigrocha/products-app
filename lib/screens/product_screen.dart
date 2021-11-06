import 'package:flutter/material.dart';
import 'package:login/services/products_service.dart';
import 'package:login/ui/input_decorations.dart';
import 'package:login/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(
                  url: productsService.selectedProduct.picture,
                ),
                Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          size: 40,
                          color: Colors.white,
                        ))),
                Positioned(
                    top: 60,
                    right: 20,
                    child: IconButton(
                        onPressed: () {
                          //todo camera\\
                        },
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          size: 40,
                          color: Colors.white,
                        )))
              ],
            ),
            _ProductForm(),
            SizedBox(height: 100)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save_alt_outlined),
        onPressed: () {
          //TODO  guardar producto
        },
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: _buildBoxDecoration(),
        child: Form(
            child: Column(
          children: [
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'Nombre del producto', labelText: 'Nombre:'),
            ),
            SizedBox(height: 30),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '\$150', labelText: 'Precio:'),
            ),
            SizedBox(height: 30),
            SwitchListTile.adaptive(
                title: Text('Disponible'),
                activeColor: Colors.indigo,
                value: true,
                onChanged: (value) {
                  //TODO pendiente
                }),
            SizedBox(height: 30),
          ],
        )),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                blurRadius: 5,
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5))
          ]);
}
