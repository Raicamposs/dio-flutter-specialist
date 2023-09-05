// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:uuid/uuid.dart';

class Address {
  final String id;
  final String zipCode;
  final String? street;
  final String? complement;
  final String? neighborhood;
  final String? locality;
  final String? uf;
  final String? ibge;
  final String? gia;
  final String? ddd;
  final String? siafi;

  Address({
    required this.id,
    required this.zipCode,
    this.street,
    this.complement,
    this.neighborhood,
    this.locality,
    this.uf,
    this.ibge,
    this.gia,
    this.ddd,
    this.siafi,
  });

  String get description {
    String result = (street ?? '').trim();

    if ((neighborhood ?? '').trim().isNotEmpty == true) {
      result += ', ${(neighborhood ?? '').trim()}';
    }

    if ((complement ?? '').trim().isNotEmpty) {
      result += ', $complement';
    }

    return result.trim();
  }

  Address copyWith({
    String? id,
    String? zipCode,
    String? street,
    String? complement,
    String? neighborhood,
    String? locality,
    String? uf,
    String? ibge,
    String? gia,
    String? ddd,
    String? siafi,
  }) {
    return Address(
      zipCode: zipCode ?? this.zipCode,
      street: street ?? this.street,
      complement: complement ?? this.complement,
      neighborhood: neighborhood ?? this.neighborhood,
      locality: locality ?? this.locality,
      uf: uf ?? this.uf,
      ibge: ibge ?? this.ibge,
      gia: gia ?? this.gia,
      ddd: ddd ?? this.ddd,
      siafi: siafi ?? this.siafi,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'zipCode': zipCode,
      'street': street,
      'complement': complement,
      'neighborhood': neighborhood,
      'locality': locality,
      'uf': uf,
      'ibge': ibge,
      'gia': gia,
      'ddd': ddd,
      'siafi': siafi,
    };
  }

  factory Address.blank() {
    return Address(
      id: const Uuid().v4(),
      zipCode: '',
    );
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      zipCode: map['zipCode'] as String,
      street: map['street'] != null ? map['street'] as String : null,
      complement:
          map['complement'] != null ? map['complement'] as String : null,
      neighborhood:
          map['neighborhood'] != null ? map['neighborhood'] as String : null,
      locality: map['locality'] != null ? map['locality'] as String : null,
      uf: map['uf'] != null ? map['uf'] as String : null,
      ibge: map['ibge'] != null ? map['ibge'] as String : null,
      gia: map['gia'] != null ? map['gia'] as String : null,
      ddd: map['ddd'] != null ? map['ddd'] as String : null,
      siafi: map['siafi'] != null ? map['siafi'] as String : null,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<Address> fromJsonList(String source) =>
      List.from(json.decode(source)).map((e) => Address.fromMap(e)).toList();
}
