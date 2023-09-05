import 'package:consulta_cep/domain/entities/address.entity.dart';

abstract class AddressSearchService {
  Future<Address> find(String address);
}
