import 'dart:convert';

import 'package:consulta_cep/data/models/via-cep-result.model.dart';
import 'package:consulta_cep/domain/entities/address.entity.dart';
import 'package:consulta_cep/domain/services/address-search.service.dart';
import 'package:http/http.dart' as http;

class ViaCepSearchService implements AddressSearchService {
  @override
  Future<Address> find(String zipCode) async {
    final onlyNumbers = zipCode.replaceAll(RegExp(r'[^\d]+'), '');
    final url = 'https://viacep.com.br/ws/$onlyNumbers/json';
    final uri = Uri.parse(url);

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar CEP');
    }

    if (json.decode(response.body)['erro'] == true) {
      throw Exception('Erro ao buscar CEP');
    }

    return ViaCepResult.fromJson(response.body).toEntity();
  }
}
