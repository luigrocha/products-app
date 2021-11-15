import 'package:flutter/material.dart';
import 'package:login/models/models.dart';
import 'package:login/screens/screens.dart';
import 'package:login/services/services.dart';
import 'package:login/share_prefs/preferencias_usuario.dart';
import 'package:login/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatelessWidget {
  static final String routeName = 'home';
  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = HomeScreen.routeName;
    final productsService = Provider.of<ProductsService>(context);
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
      //if (mounted) setState(() {});
      _refreshController.loadComplete();
    }

    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text('CR-Store'),
            backgroundColor:
                (prefs.colorSecundario) ? Colors.black87 : Colors.cyan[800],
            titleSpacing: 1,
            actions: [
              IconButton(
                icon: Icon(Icons.logout_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.architecture),
                onPressed: () {},
              ),
            ],
            elevation: 0,
            bottom: TabBar(
              indicatorWeight: 5,
              indicatorColor: Colors.cyan,
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                ),
                Tab(
                  icon: Icon(Icons.list),
                ),
                Tab(
                  icon: Icon(Icons.select_all),
                ),
                Tab(
                  icon: Icon(Icons.face),
                ),
              ],
            ),
            /*flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blue, Colors.red])),
        ),*/
          ),
          body: TabBarView(
            children: [
              InicioWidget(),
              FavWidget(),
              InicioWidget(),
              InicioWidget(),
            ],
          ),
          drawer: MenuWidget(),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              productsService.selectedProduct =
                  new Product(available: true, name: '', price: 0, desc: '');
              Navigator.pushNamed(context, 'product');
            },
          ),
        ));
  }
}
