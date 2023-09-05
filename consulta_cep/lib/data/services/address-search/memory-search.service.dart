import 'package:consulta_cep/data/models/via-cep-result.model.dart';
import 'package:consulta_cep/domain/entities/address.entity.dart';
import 'package:consulta_cep/domain/services/address-search.service.dart';

class LocalSearchService implements AddressSearchService {
  @override
  Future<Address> find(String address) {
    return Future.value(ViaCepResult.fromMap({
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
    }).toEntity());
  }
}
