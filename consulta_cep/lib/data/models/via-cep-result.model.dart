import 'dart:convert';

import 'package:consulta_cep/domain/entities/address.entity.dart';
import 'package:uuid/uuid.dart';

class ViaCepResult {
  final String? cep;
  final String? logradouro;
  final String? complemento;
  final String? bairro;
  final String? localidade;
  final String? uf;
  final String? ibge;
  final String? gia;
  final String? ddd;
  final String? siafi;

  ViaCepResult({
    this.cep,
    this.logradouro,
    this.complemento,
    this.bairro,
    this.localidade,
    this.uf,
    this.ibge,
    this.gia,
    this.ddd,
    this.siafi,
  });

  ViaCepResult copyWith({
    String? cep,
    String? logradouro,
    String? complemento,
    String? bairro,
    String? localidade,
    String? uf,
    String? ibge,
    String? gia,
    String? ddd,
    String? siafi,
  }) {
    return ViaCepResult(
      cep: cep ?? this.cep,
      logradouro: logradouro ?? this.logradouro,
      complemento: complemento ?? this.complemento,
      bairro: bairro ?? this.bairro,
      localidade: localidade ?? this.localidade,
      uf: uf ?? this.uf,
      ibge: ibge ?? this.ibge,
      gia: gia ?? this.gia,
      ddd: ddd ?? this.ddd,
      siafi: siafi ?? this.siafi,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cep': cep,
      'logradouro': logradouro,
      'complemento': complemento,
      'bairro': bairro,
      'localidade': localidade,
      'uf': uf,
      'ibge': ibge,
      'gia': gia,
      'ddd': ddd,
      'siafi': siafi,
    };
  }

  factory ViaCepResult.fromMap(Map<String, dynamic> map) {
    return ViaCepResult(
      cep: map['cep'] != null ? map['cep'] as String : null,
      logradouro:
          map['logradouro'] != null ? map['logradouro'] as String : null,
      complemento:
          map['complemento'] != null ? map['complemento'] as String : null,
      bairro: map['bairro'] != null ? map['bairro'] as String : null,
      localidade:
          map['localidade'] != null ? map['localidade'] as String : null,
      uf: map['uf'] != null ? map['uf'] as String : null,
      ibge: map['ibge'] != null ? map['ibge'] as String : null,
      gia: map['gia'] != null ? map['gia'] as String : null,
      ddd: map['ddd'] != null ? map['ddd'] as String : null,
      siafi: map['siafi'] != null ? map['siafi'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ViaCepResult.fromJson(String source) =>
      ViaCepResult.fromMap(json.decode(source) as Map<String, dynamic>);

  Address toEntity() => Address(
        id: const Uuid().v4(),
        complement: complemento,
        ddd: ddd,
        gia: gia,
        ibge: ibge,
        locality: localidade,
        neighborhood: bairro,
        siafi: siafi,
        street: logradouro,
        uf: uf,
        zipCode: cep ?? '',
      );
}
