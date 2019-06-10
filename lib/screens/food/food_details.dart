import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nkitchen/provider/products.dart';

class FoodDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    AppBar appBar = new AppBar(
        primary: false,
        leading: IconTheme(
            data: IconThemeData(color: Colors.white), child: CloseButton()),
        flexibleSpace: Container(
          decoration: BoxDecoration(),
        ),
        backgroundColor: Colors.transparent);
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: Hero(
        tag: productsProvider.id,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 400.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  productsProvider.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverFillRemaining(
              child: Material(
                child: Column(
                  children: <Widget>[
                    // Container(
                    //   height: mediaQuery.padding.top,
                    // ),
                    Container(
                      height: mediaQuery.padding.top,
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(productsProvider.description),
                        subtitle: Text(productsProvider.price.toString()),
                      ),
                    ),
                    Expanded(
                      child: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi et vulputate nisi, id dapibus ligula. Nullam fringilla magna sed nisl porttitor, vitae pharetra tortor fermentum. Nulla convallis, erat in consequat rhoncus, sapien ipsum vulputate turpis, vel commodo felis elit eget metus. Pellentesque sed tristique erat, eu placerat ante. Nullam purus lectus, elementum non ipsum at, malesuada fermentum justo. Curabitur fermentum ac dolor in ornare. Cras vitae leo quis elit malesuada cursus."),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
    Widget heroWidget = Stack(children: <Widget>[
      Hero(
        tag: "card$num",
        child: Material(
          child: Column(
            children: <Widget>[
              AspectRatio(
                // Medida que se encuentre justo en el bordo de la pantalla es 568.0 / 380.0
                // Medida debajo de la barra de sistema es  485.0 / 380.0
                aspectRatio: 485.0 / 380.0,
                child: Image.network(productsProvider.image),
              ),
              Material(
                child: ListTile(
                  title: Text(productsProvider.description),
                  subtitle: Text(productsProvider.price.toString()),
                ),
              ),
              Expanded(
                child: Center(
                    child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi et vulputate nisi, id dapibus ligula. Nullam fringilla magna sed nisl porttitor, vitae pharetra tortor fermentum. Nulla convallis, erat in consequat rhoncus, sapien ipsum vulputate turpis, vel commodo felis elit eget metus. Pellentesque sed tristique erat, eu placerat ante. Nullam purus lectus, elementum non ipsum at, malesuada fermentum justo. Curabitur fermentum ac dolor in ornare. Cras vitae leo quis elit malesuada cursus.")),
              )
            ],
          ),
        ),
      ),
      Column(
          // children: <Widget>[
          //   Container(
          //     height: mediaQuery.padding.top,
          //   ),
          //   ConstrainedBox(
          //     constraints: BoxConstraints(maxHeight: 275),
          //     child: appBar,
          //   )
          // ],
          ),
    ]);
  }
}
