import 'package:projeto_vaga_garagem/models/vaga_model.dart';

sealed class BuscaCadastroState {}

class BuscaCadastroInitial extends BuscaCadastroState {}

class BuscaCadastroLoading extends BuscaCadastroState {}

class BuscaCadastroLoaded extends BuscaCadastroState {
  var listaVagas = <VagaModel>[];
  BuscaCadastroLoaded(this.listaVagas);
}

class BuscaCadastroError extends BuscaCadastroState {
  String message;
  BuscaCadastroError(
    this.message,
  );
}
