import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: Wrap(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/busca');
              },
              child: const Text('Buscar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed('/cadastro'),
              child: const Text('Inserir novo registro'),
            ),
          ],
        ));
  }
}
