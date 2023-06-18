import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_app/provider/cart_provider.dart';
import 'package:shopping_cart_app/screens/bloqueo.dart';
import 'package:shopping_cart_app/screens/confirmacion.dart';
import 'package:shopping_cart_app/screens/product_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //scheduleTimeout(context, 2 * 1000); // 5 seconds.
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'App Compras',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const ProductList(),
        );
      }),
    );
  }
}
//void main() {
//  scheduleTimeout(5 * 1000); // 5 seconds.
//}

Timer scheduleTimeout(context, [int milliseconds = 10000]) =>
    Timer(Duration(milliseconds: milliseconds), handleTimeout(context));

handleTimeout(context) {
  return () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Bloqueo()),
        )
      };
  // callback function
  // Do some work.
}
