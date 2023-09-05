import 'package:consulta_cep/domain/entities/address.entity.dart';
import 'package:consulta_cep/domain/services/address-api.service.dart';

class UpdateAddressUseCase {
  final AddressApiService _service;

  UpdateAddressUseCase(this._service);

  Future<Address> call(Address address) async {
    return _service.update(address);
  }
}
