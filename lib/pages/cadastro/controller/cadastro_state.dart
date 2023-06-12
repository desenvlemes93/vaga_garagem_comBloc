sealed class CadastroState {}

class CadastroInicial extends CadastroState {}

class CadastroLoading extends CadastroState {}

class CadastroLoaded extends CadastroState {}

class CadastroError extends CadastroState {
  String message;
  CadastroError(
    this.message,
  );
}
