import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_vaga_garagem/core/ui/loader.dart';
import 'package:projeto_vaga_garagem/pages/cadastro/controller/cadastro_controller.dart';
import 'package:projeto_vaga_garagem/pages/cadastro/controller/cadastro_state.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/ui/snack_bar.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> with Loader, SnacBar {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _informacoesEC = TextEditingController();
  final _complementoEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _informacoesEC.dispose();
    _complementoEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Vaga'),
      ),
      body: Form(
        key: _formKey,
        child: BlocConsumer<CadastroController, CadastroState>(
          listener: (context, state) async {
            switch (state) {
              case CadastroLoading():
                showLoader();
                return;
              case CadastroError():
                hideLoader();
              case CadastroLoaded():
                hideLoader();
                Navigator.of(context, rootNavigator: false).pushNamed('/');
              default:
            }
          },
          builder: (context, state) {
            return switch (state) {
              CadastroInicial() => LayoutBuilder(
                  builder: (_, constrains) {
                    return ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constrains.maxHeight),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _emailEC,
                                validator: Validatorless.multiple([
                                  Validatorless.email('E-mail inválido'),
                                ]),
                                decoration: InputDecoration(
                                  labelText: 'E-mail',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                validator: Validatorless.min(
                                    6, 'Minino de 6 caracteres'),
                                controller: _informacoesEC,
                                decoration: InputDecoration(
                                  labelText: 'Informações da Vaga',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: _complementoEC,
                                maxLength: 50,
                                decoration: InputDecoration(
                                  labelText: 'Complemento',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final _validFormey =
                                        _formKey.currentState?.validate() ??
                                            false;

                                    if (_validFormey) {
                                      await context
                                          .read<CadastroController>()
                                          .cadastrarVaga(
                                              email: _emailEC.text,
                                              informacoes: _informacoesEC.text,
                                              complemento: _complementoEC.text);
                                      showSnackBar(
                                        'Cadastro Realizado com Sucesso',
                                        Colors.blue,
                                      );
                                    }
                                  },
                                  child: const Text('Salvar'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              _ => SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}
