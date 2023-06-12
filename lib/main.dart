import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:projeto_vaga_garagem/pages/busca/busca_cadastro_page.dart';
import 'package:projeto_vaga_garagem/pages/busca/controller/busca_cadastro_controller.dart';
import 'package:projeto_vaga_garagem/pages/cadastro/cadastro_page.dart';
import 'package:projeto_vaga_garagem/pages/cadastro/controller/cadastro_controller.dart';
import 'package:projeto_vaga_garagem/pages/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('pt', 'Br'),
      title: 'Vaga de Garagem',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (_) => const HomePage(),
        '/busca': (_) => BlocProvider(
              create: (_) => BuscaCadastroController(),
              child: const BuscaCadastroPage(),
            ),
        '/cadastro': (_) => BlocProvider(
              create: (_) => CadastroController(),
              child: const CadastroPage(),
            ),
      },
    );
  }
}
