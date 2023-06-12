import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:projeto_vaga_garagem/models/vaga_model.dart';
import 'package:projeto_vaga_garagem/repository/vaga_repository.dart';

import '../core/exception/exeception_busca.dart';

class VagaRepositoryImpl implements VagaRepository {
  @override
  Future<(ExeceptionBusca?, List<VagaModel>)> buscaVaga() async {
    final _dio = Dio();

    var vagaResult = await _dio.get('http://192.168.0.106:8080/vaga_garagem');

    var vagasData = vagaResult.data as List;

    var vagas = vagasData.map((e) => VagaModel.fromMap(e)).toList();

    return (null, vagas);
  }

  Future<Response> response() async {
    final _dio = Dio();
    final response = await _dio.request(
      "http://192.168.0.106:8080/users/auth",
      data: {
        "email": "rodrigorahman@academiadoflutter.com.br",
        "password": "123"
      },
    );

    return response;
  }

  @override
  Future<void> alterarVaga(VagaModel vagaModel) async {
    try {
      final _dio = Dio();
      _dio.options.baseUrl = 'http://192.168.0.106:8080/vaga_garagem';
      final res = await response();
      await _dio.put(
        '/${vagaModel.id}',
        data: vagaModel.toMap(),
        options: Options(
          responseType: ResponseType.json,
          contentType: Headers.jsonContentType,
          headers: {
            HttpHeaders.authorizationHeader:
                'Bearer ${res.data['access_token']}',
            'content-Type': 'application/json',
            HttpHeaders.accessControlAllowOriginHeader: {
              'access-control-allow-origin'
            },
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
      );
    } on Exception catch (e, s) {
      log(
        'Errop ao retorna',
        error: e,
        stackTrace: s,
      );
    }
  }

  @override
  Future<void> cadastraVaga(
      String email, String informacoes, String complemento) async {
    try {
      final _dio = Dio();
      final res = await response();
      await _dio.post(
        'http://192.168.0.106:8080/vaga_garagem',
        data: {
          "email": email,
          "busy": false,
          "name": informacoes,
          "date_inicio": "",
          "date_final": "",
          "complemento": [
            complemento,
          ],
        },
        options: Options(
          responseType: ResponseType.json,
          contentType: Headers.jsonContentType,
          headers: {
            HttpHeaders.authorizationHeader:
                'Bearer ${res.data['access_token']}',
            'content-Type': 'application/json',
            HttpHeaders.accessControlAllowOriginHeader: {
              'access-control-allow-origin'
            },
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
      );
    } on Exception catch (e, s) {
      log(
        'Erro ao cadastrar Vaga',
        error: e,
        stackTrace: s,
      );
    }
  }
}
