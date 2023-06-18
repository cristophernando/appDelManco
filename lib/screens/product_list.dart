import 'package:badges/badges.dart' as pbad;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_app/model/item_model.dart';
import 'package:shopping_cart_app/provider/cart_provider.dart';
import 'package:shopping_cart_app/database/db_helper.dart';
import 'package:shopping_cart_app/model/cart_model.dart';
import 'package:shopping_cart_app/screens/cart_screen.dart';
import 'package:logger/logger.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  DBHelper dbHelper = DBHelper();

  List<Item> products = [
    Item(
        name: 'Don Café',
        unit: '50 g',
        price: 1.24,
        image: 'assets/images/doncafe.jpg'),
    Item(
        name: 'Azucar',
        unit: '1 lb',
        price: 0.48,
        image: 'assets/images/azucar.jpg'),
    Item(
        name: 'Leche',
        unit: '900 ml',
        price: 0.90,
        image: 'assets/images/leche.jpg'),
    Item(
        name: 'Arroz',
        unit: '1 lb',
        price: 0.60,
        image: 'assets/images/arroz.webp'),
    Item(
        name: 'Aceite Sabroson',
        unit: '900 ml',
        price: 2.59,
        image: 'assets/images/aceite.webp'),
    Item(
        name: 'Dasani',
        unit: '600 ml',
        price: 0.50,
        image: 'assets/images/agua.jpg'),
    Item(
        name: 'Coca Cola',
        unit: '350 ml',
        price: 0.50,
        image: 'assets/images/coca350.png'),
    Item(
        name: 'Coca Cola',
        unit: '1 lt',
        price: 1.10,
        image: 'assets/images/coca1.jpg'),
    Item(
        name: 'Pilsener 6 pack',
        unit: '355 ml',
        price: 5.35,
        image: 'assets/images/pilsener.jpg'),
    Item(
        name: 'Club 6 pack',
        unit: '355 ml',
        price: 6.29,
        image: 'assets/images/club.png'),
    Item(
        name: 'Siembra 6 pack',
        unit: '355 ml',
        price: 5.19,
        image: 'assets/images/siembra.png'),
    Item(
        name: 'Biela 6 pack',
        unit: '355 ml',
        price: 4.99,
        image: 'assets/images/biela6p.webp'),
    Item(
        name: 'Vino Valle de Mar',
        unit: '750 ml',
        price: 4.99,
        image: 'assets/images/vino.webp'),
    Item(
        name: 'Wisky Old Times',
        unit: '745 ml',
        price: 10.99,
        image: 'assets/images/wisky.jpg'),
    Item(
        name: 'Biela 12 pack',
        unit: '355 ml',
        price: 10,
        image: 'assets/images/biela12p.png'),
    Item(
        name: 'Combo Wisky, hielo y agua mineral',
        unit: '750 ml',
        price: 12.99,
        image: 'assets/images/combo.webp'),
    Item(
        name: 'Atun Real',
        unit: '180 gr',
        price: 0.80,
        image: 'assets/images/atun.jpg'),
  ];

  //List<bool> clicked = List.generate(10, (index) => false, growable: true);
  @override
  Widget build(BuildContext context) {
    final logger = Logger();
    final cart = Provider.of<CartProvider>(context);
    void saveData(int index) {
      dbHelper
          .insert(
        Cart(
          id: index,
          productId: index.toString(),
          productName: products[index].name,
          initialPrice: products[index].price,
          productPrice: products[index].price,
          quantity: ValueNotifier(1),
          unitTag: products[index].unit,
          image: products[index].image,
        ),
      )
          .then((value) {
        cart.addTotalPrice(products[index].price.toDouble());
        cart.addCounter();
        logger.log(Level.info, 'Product Added to cart');
      }).onError((error, stackTrace) {
        logger.log(Level.info, error.toString());
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Lista de productos'),
        actions: [
          pbad.Badge(
            badgeContent: Consumer<CartProvider>(
              builder: (context, value, child) {
                return Text(
                  value.getCounter().toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              },
            ),
            position: const pbad.BadgePosition(start: 30, bottom: 30),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CartScreen()));
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          shrinkWrap: true,
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.blueGrey.shade200,
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image(
                      height: 200,
                      width: 200,
                      image: AssetImage(products[index].image.toString()),
                    ),
                    SizedBox(
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5.0,
                          ),
                          RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            text: TextSpan(
                                text: 'Nombre: ',
                                style: TextStyle(
                                    color: Colors.blueGrey.shade800,
                                    fontSize: 16.0),
                                children: [
                                  TextSpan(
                                      text:
                                          '${products[index].name.toString()}\n',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ]),
                          ),
                          RichText(
                            maxLines: 2,
                            text: TextSpan(
                                text: 'Unidades: ',
                                style: TextStyle(
                                    color: Colors.blueGrey.shade800,
                                    fontSize: 16.0),
                                children: [
                                  TextSpan(
                                      text:
                                          '${products[index].unit.toString()}\n',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ]),
                          ),
                          RichText(
                            maxLines: 2,
                            text: TextSpan(
                                text: 'Precio: ' r"$",
                                style: TextStyle(
                                    color: Colors.blueGrey.shade800,
                                    fontSize: 16.0),
                                children: [
                                  TextSpan(
                                      text:
                                          '${products[index].price.toString()}\n',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ]),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey.shade900),
                        onPressed: () {
                          saveData(index);
                        },
                        child: const Text('Agregar a carrito')),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
