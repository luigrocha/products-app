import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/providers/product_form_provider.dart';
import 'package:login/services/products_service.dart';
import 'package:login/ui/input_decorations.dart';
import 'package:login/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productsService.selectedProduct),
      child: _ProductScreenBody(productsService: productsService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productsService,
  }) : super(key: key);

  final ProductsService productsService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(
                  url: productsService.selectedProduct.picture,
                ),
                Positioned(
                    top: 50,
                    left: 0,
                    child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          size: 40,
                          color: Colors.white,
                        ))),
                Positioned(
                    top: 50,
                    right: 20,
                    child: IconButton(
                        onPressed: () async {
                          final picker = new ImagePicker();
                          final PickedFile? pickedFile = await picker.getImage(
                              source: ImageSource.camera, imageQuality: 100);
                          if (pickedFile == null) {
                            print('no hay img');
                            return;
                          }
                          productsService
                              .updateSelectedProductImage(pickedFile.path);
                        },
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          size: 40,
                          color: Colors.white,
                        ))),
                Positioned(
                    top: 90,
                    right: 20,
                    child: IconButton(
                        onPressed: () async {
                          final picker = new ImagePicker();
                          final PickedFile? pickedFile = await picker.getImage(
                              source: ImageSource.gallery, imageQuality: 100);
                          if (pickedFile == null) {
                            return;
                          }
                          productsService
                              .updateSelectedProductImage(pickedFile.path);
                        },
                        icon: Icon(
                          Icons.image_outlined,
                          size: 40,
                          color: Colors.white,
                        ))),
              ],
            ),
            _ProductForm(),
            SizedBox(height: 100)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: productsService.isSaving
            ? CircularProgressIndicator(
                color: Colors.white,
              )
            : Icon(Icons.save_alt_outlined),
        onPressed: productsService.isSaving
            ? null
            : () async {
                if (!productForm.isValidForm()) return;

                final String? imageUrl = await productsService.uploadImage();
                if (imageUrl != null) productForm.product.picture = imageUrl;

                await productsService.saveorCreateProduct(productForm.product);
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
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        width: double.infinity,
        height: 400,
        decoration: _buildBoxDecoration(),
        child: Form(
            key: productForm.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                SizedBox(height: 10),
                TextFormField(
                  initialValue: product.name,
                  onChanged: (value) => product.name = value,
                  validator: (value) {
                    if (value == null || value.length < 1)
                      return 'El nombre es obligatorio';
                  },
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'Nombre del producto', labelText: 'Nombre:'),
                ),
                SizedBox(height: 10),
                TextFormField(
                  initialValue: product.desc,
                  onChanged: (value) => product.desc = value,
                  validator: (value) {
                    if (value == null || value.length < 1)
                      return 'La descripción es obligatorio';
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'Descripción', labelText: 'Descripción:'),
                ),
                SizedBox(height: 10),
                TextFormField(
                  initialValue: '${product.price}',
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  onChanged: (value) {
                    if (double.tryParse(value) == null) {
                      product.price = 0;
                    } else {
                      product.price = double.parse(value);
                    }
                  },
                  validator: (value) {
                    if (value == null || value.length < 1)
                      return 'El precio es obligatorio';
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.authInputDecoration(
                      hintText: '\$150', labelText: 'Precio:'),
                ),
                SizedBox(height: 10),
                SwitchListTile.adaptive(
                    title: Text('Disponible'),
                    activeColor: Colors.cyan,
                    value: product.available,
                    onChanged: productForm.updateAvailability),
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
