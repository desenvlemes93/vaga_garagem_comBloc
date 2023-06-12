import 'package:projeto_vaga_garagem/models/vaga_model.dart';

import '../core/exception/exeception_busca.dart';

abstract interface class VagaRepository {
  Future<(ExeceptionBusca?, List<VagaModel>)> buscaVaga();
  Future<void> alterarVaga(VagaModel vagaModel);
  Future<void> cadastraVaga(
      String email, String informacoes, String complemento);
}
