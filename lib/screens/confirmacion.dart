import 'package:flutter/material.dart';

import 'package:logger/logger.dart';

class Confirmacion extends StatefulWidget {
  const Confirmacion({
    Key? key,
  }) : super(key: key);

  @override
  State<Confirmacion> createState() => _ConfirmacionState();
}

class _ConfirmacionState extends State<Confirmacion> {
  var logger = Logger();

  get child => null;

  get icon => null;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: const Column(children: [
        Expanded(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Icon(Icons.done),
              ),
              Text(
                'Se realizo la compra con Éxito',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              )
            ],
          )),
        ),
      ]),
      bottomNavigationBar: InkWell(
        onTap: () => {Navigator.popUntil(context, ModalRoute.withName('/'))},
        child: Container(
          color: Colors.yellow.shade600,
          alignment: Alignment.center,
          height: 50.0,
          child: const Text(
            'Proceder al pago',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
