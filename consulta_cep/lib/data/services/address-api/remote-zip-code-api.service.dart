import 'package:consulta_cep/domain/entities/address.entity.dart';
import 'package:consulta_cep/domain/services/address-api.service.dart';
import 'package:http/http.dart' as http;

class RemoteAddressApiService implements AddressApiService {
  final String _baseUrl = 'http://localhioost:3000/addresses';

  @override
  Future<Address> create(Address address) async {
    final url = _baseUrl;
    final uri = Uri.parse(url);

    final response = await http.post(uri, body: address.toJson());

    if (response.statusCode != 200) {
      throw Exception('Erro ao criar endereço');
    }

    return Address.fromJson(response.body);
  }

  @override
  Future<bool> delete(String address) async {
    final url = '$_baseUrl/$address';
    final uri = Uri.parse(url);

    final response = await http.delete(uri);
    return response.statusCode == 200;
  }

  @override
  Future<Address> find(String zipCode) async {
    final onlyNumbers = zipCode.replaceAll(RegExp(r'[^\d]+'), '');

    final url = '$_baseUrl/zip-cede/$onlyNumbers';
    final uri = Uri.parse(url);

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar CEP');
    }

    return Address.fromJson(response.body);
  }

  @override
  Future<List<Address>> findAll() async {
    final uri = Uri.parse(_baseUrl);
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar CEP');
    }

    return Address.fromJsonList(response.body);
  }

  @override
  Future<Address> update(Address address) async {
    final url = _baseUrl;
    final uri = Uri.parse(url);

    final response = await http.put(uri, body: address.toJson());

    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar endereço');
    }

    return Address.fromJson(response.body);
  }
}
