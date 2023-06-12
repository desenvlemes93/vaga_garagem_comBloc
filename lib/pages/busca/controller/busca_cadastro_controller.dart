import 'package:bloc/bloc.dart';
import 'package:projeto_vaga_garagem/models/vaga_model.dart';
import 'package:projeto_vaga_garagem/pages/busca/controller/busca_cadastro_state.dart';
import 'package:projeto_vaga_garagem/repository/vaga_repository.dart';
import 'package:projeto_vaga_garagem/repository/vaga_repository_impl.dart';

class BuscaCadastroController extends Cubit<BuscaCadastroState> {
  BuscaCadastroController() : super(BuscaCadastroInitial());

  Future<void> buscarVaga() async {
    VagaRepository vagaRepository = VagaRepositoryImpl();

    emit(BuscaCadastroLoading());
    var (exception, vagas) = await vagaRepository.buscaVaga();
    emit(BuscaCadastroLoaded(vagas));
    switch (exception) {}
  }

  Future<void> alterarDados(VagaModel vagaModel) async {
    VagaRepository vagaRepository = VagaRepositoryImpl();

    emit(BuscaCadastroLoading());

    final listaAtualizada = await vagaRepository.alterarVaga(vagaModel);
    emit(BuscaCadastroInitial());
    var (excetion, listaFinal) = await vagaRepository.buscaVaga();
    emit(BuscaCadastroLoaded(listaFinal));
  }
}
