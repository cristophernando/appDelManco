import 'package:flutter/material.dart';

import 'package:logger/logger.dart';

class Bloqueo extends StatefulWidget {
  const Bloqueo({
    Key? key,
  }) : super(key: key);

  @override
  State<Bloqueo> createState() => _BloqueoState();
}

class _BloqueoState extends State<Bloqueo> {
  var logger = Logger();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: const Expanded(
        child: Center(child: Text("en espera")),
      ),
    );
    // TODO: implement build
  }
}
