import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:projeto_vaga_garagem/repository/vaga_repository.dart';
import 'package:projeto_vaga_garagem/repository/vaga_repository_impl.dart';

import 'cadastro_state.dart';

class CadastroController extends Cubit<CadastroState> {
  CadastroController() : super(CadastroInicial());

  Future<void> cadastrarVaga({
    required String email,
    required String informacoes,
    required String complemento,
  }) async {
    try {
      final VagaRepository vagaRepository = VagaRepositoryImpl();
      emit(CadastroLoading());
      await vagaRepository.cadastraVaga(
        email,
        informacoes,
        complemento,
      );
      emit(CadastroLoaded());
    } on Exception catch (e, s) {
      log('Erro ao cadastrar vaga', error: e, stackTrace: s);
      emit(CadastroError('Erro ao cadastrar Vaga'));
    }
  }
}
