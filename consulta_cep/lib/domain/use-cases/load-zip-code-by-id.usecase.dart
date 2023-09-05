import 'package:consulta_cep/domain/entities/address.entity.dart';
import 'package:consulta_cep/domain/services/address-api.service.dart';

class LoadAddressByIdUseCase {
  final AddressApiService _service;

  LoadAddressByIdUseCase(this._service);

  Future<Address> call(String address) async {
    if (address.isEmpty) {
      throw ArgumentError("Zip Code must not be null or empty");
    }

    if (!RegExp(r"^[0-9]{8}$").hasMatch(address)) {
      throw ArgumentError("Invalid Zip Code");
    }

    return _service.find(address);
  }
}
