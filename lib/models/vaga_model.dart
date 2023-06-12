import 'dart:convert';

class VagaModel {
  final int id;
  final String email;
  final String name;

  bool busy;
  String? dateInicio;
  String? dateFinal;
  final List<String>? complemento;
  VagaModel({
    required this.id,
    required this.email,
    required this.name,
    required this.busy,
    this.dateInicio,
    this.dateFinal,
    this.complemento,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'busy': busy,
      'date_inicio': dateInicio ?? '',
      'date_final': dateFinal ?? '',
      'complemento': complemento ?? [],
    };
  }

  factory VagaModel.fromMap(Map<String, dynamic> map) {
    return VagaModel(
      id: map['id']?.toInt() ?? 0,
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      busy: map['busy'] ?? false,
      dateInicio: map['date_inicio'] != null ? (map['date_inicio']) : '',
      dateFinal: map['date_final'] != null ? (map['date_final']) : '',
      complemento: List<String>.from(map['complemento'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory VagaModel.fromJson(String source) =>
      VagaModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VagaModel(id: $id, name: $name, busy: $busy, dateInicio: $dateInicio, dateFinal: $dateFinal, complemento: $complemento)';
  }
}
