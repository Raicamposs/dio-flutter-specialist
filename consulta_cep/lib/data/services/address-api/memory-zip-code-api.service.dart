import 'package:consulta_cep/data/models/via-cep-result.model.dart';
import 'package:consulta_cep/domain/entities/address.entity.dart';
import 'package:consulta_cep/domain/services/address-api.service.dart';

class AddressApiInMemoryService implements AddressApiService {
  final _data = [
    ViaCepResult.fromMap({
      "cep": "01001-000",
      "logradouro": "Praça da Sé",
      "complemento": "lado ímpar",
      "bairro": "Sé",
      "localidade": "São Paulo",
      "uf": "SP",
      "ibge": "3550308",
      "gia": "1004",
      "ddd": "11",
      "siafi": "7107"
    }).toEntity(),
    ViaCepResult.fromMap({
      "cep": "29210-190",
      "logradouro": "Avenida Antônio Guimarães",
      "complemento": "",
      "bairro": "Itapebussu",
      "localidade": "Guarapari",
      "uf": "ES",
      "ibge": "3202405",
      "gia": "",
      "ddd": "27",
      "siafi": "5647"
    }).toEntity()
  ];

  @override
  Future<Address> create(Address address) {
    _data.removeWhere((element) => element.zipCode == address.zipCode);
    _data.add(address);
    return Future.value(address);
  }

  @override
  Future<bool> delete(String id) {
    _data.removeWhere((element) => element.id == id);
    return Future.value(true);
  }

  @override
  Future<Address> find(String id) {
    return Future.value(_data.firstWhere((element) => element.id == id));
  }

  @override
  Future<List<Address>> findAll() {
    return Future.value(_data);
  }

  @override
  Future<Address> update(Address address) {
    _data.removeWhere((element) => element.id == address.id);
    _data.add(address);
    return Future.value(address);
  }
}
