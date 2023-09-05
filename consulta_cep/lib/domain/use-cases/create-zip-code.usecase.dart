import 'package:consulta_cep/domain/entities/address.entity.dart';
import 'package:consulta_cep/domain/services/address-api.service.dart';

class CreateAddressUseCase {
  final AddressApiService _service;

  CreateAddressUseCase(this._service);

  Future<Address> call(Address address) async {
    return _service.create(address);
  }
}
