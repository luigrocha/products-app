import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/models/models.dart';
import 'package:login/screens/screens.dart';
import 'package:login/services/services.dart';
import 'package:login/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);

    if (productsService.isLoading) return LoadingScreen();
    void _onRefresh() async {
      // monitor network fetch
      await Future.delayed(Duration(milliseconds: 1000));
      // if failed,use refreshFailed()
      _refreshController.refreshCompleted();
    }

    void _onLoading() async {
      // monitor network fetch
      await Future.delayed(Duration(milliseconds: 1000));
      // if failed,use loadFailed(),if no data return,use LoadNodata()
      //TODO
      //items.add((items.length + 1).toString());
      //productsService.products;
      //if (mounted) setState(() {});
      _refreshController.loadComplete();
    }

    return Scaffold(
      appBar: AppBar(title: Text('CR-Store'), actions: [
        IconButton(
          icon: Icon(Icons.logout_outlined),
          onPressed: () async {
            await authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ]),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up para cargar");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Fallo la carga ! Reintentar!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("cargar más");
            } else {
              body = Text("No hay mas datos");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
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
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          productsService.selectedProduct =
              new Product(available: true, name: '', price: 0);
          Navigator.pushNamed(context, 'product');
        },
      ),
    );
  }
}
