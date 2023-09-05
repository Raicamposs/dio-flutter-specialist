import 'package:consulta_cep/domain/entities/address.entity.dart';

abstract class AddressApiService {
  Future<Address> find(String id);
  Future<List<Address>> findAll();
  Future<Address> create(Address address);
  Future<Address> update(Address address);
  Future<bool> delete(String id);
}
