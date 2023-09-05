import 'package:consulta_cep/domain/entities/address.entity.dart';
import 'package:consulta_cep/domain/services/address-api.service.dart';

class LoadAddressUseCase {
  final AddressApiService _service;

  LoadAddressUseCase(this._service);

  Future<List<Address>> call(String address) async {
    return _service.findAll();
  }
}
