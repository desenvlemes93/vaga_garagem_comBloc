import 'package:flutter/material.dart';

mixin SnacBar<T extends StatefulWidget> on State<T> {
  void showSnackBar(String texto, Color cor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(texto),
        backgroundColor: cor,
      ),
    );
  }
}
