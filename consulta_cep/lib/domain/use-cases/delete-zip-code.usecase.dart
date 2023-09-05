import 'package:consulta_cep/domain/services/address-api.service.dart';

class DeleteAddressUseCase {
  final AddressApiService _service;

  DeleteAddressUseCase(this._service);

  Future<bool> call(String address) async {
    if (address.isEmpty) {
      throw ArgumentError("Zip Code must not be null or empty");
    }

    if (!RegExp(r"^[0-9]{8}$").hasMatch(address)) {
      throw ArgumentError("Invalid Zip Code");
    }

    try {
      return _service.delete(address);
    } catch (e) {
      return false;
    }
  }
}
