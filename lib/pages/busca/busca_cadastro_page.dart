import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_vaga_garagem/core/ui/loader.dart';
import 'package:projeto_vaga_garagem/pages/busca/controller/busca_cadastro_controller.dart';
import 'package:projeto_vaga_garagem/pages/busca/controller/busca_cadastro_state.dart';

class BuscaCadastroPage extends StatefulWidget {
  const BuscaCadastroPage({super.key});

  @override
  State<BuscaCadastroPage> createState() => _BuscaCadastroPageState();
}

class _BuscaCadastroPageState extends State<BuscaCadastroPage> with Loader {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BuscaCadastroController>().buscarVaga();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Busca Vaga'),
      ),
      body: BlocConsumer<BuscaCadastroController, BuscaCadastroState>(
        listener: (context, state) {
          switch (state) {
            case BuscaCadastroLoading():
              showLoader();
              return;
            case BuscaCadastroLoaded():
              hideLoader();
              return;

            default:
            //   hideLoader();
          }
        },
        builder: (context, state) {
          return switch (state) {
            BuscaCadastroLoaded(listaVagas: var listaVagas) => ListView.builder(
                itemCount: listaVagas.length,
                itemBuilder: (context, index) {
                  var nomes = listaVagas[index];
                  return InkWell(
                    onTap: () async {
                      nomes.busy = !nomes.busy;

                      await context
                          .read<BuscaCadastroController>()
                          .alterarDados(nomes);
                    },
                    child: Card(
                      shadowColor: Colors.grey,
                      elevation: 10,
                      color: nomes.busy == true ? Colors.red : Colors.green,
                      child: Wrap(
                        children: [
                          ListTile(
                            dense: true,
                            leading: const Icon(Icons.car_crash),
                            title: Text(
                                'Vaga ${nomes.busy == true ? 'Ocupada' : 'Disponivel'}'),
                            subtitle: Text(nomes.name),
                          ),
                          Wrap(
                            runSpacing: 5,
                            //spacing: MediaQuery.sizeOf(context).height * 0.2,
                            children: [
                              const Icon(
                                Icons.access_alarm,
                              ),
                              const Text('Data Incio:'),
                              Text('  ${nomes.dateInicio}'),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Center(
                                  child: Column(
                                    children: nomes.complemento
                                            ?.map((e) => Text(e))
                                            .toList() ??
                                        [],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}
