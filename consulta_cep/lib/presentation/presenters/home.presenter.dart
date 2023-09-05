import 'dart:async';

import 'package:consulta_cep/domain/entities/address.entity.dart';
import 'package:consulta_cep/domain/services/address-search.service.dart';
import 'package:flutter/foundation.dart';

import '../../domain/services/address-api.service.dart';

class HomePresenter extends ValueNotifier<List<Address>> {
  final AddressApiService service;
  final AddressSearchService searchService;
  HomePresenter(this.service, this.searchService, {List<Address>? value})
      : super(value ?? []);

  Future<Address?> search(String zipCode) async {
    try {
      final address = await searchService.find(zipCode);
      return address;
    } catch (e) {
      return null;
    }
  }

  Future<void> findAll() async {
    value = await service.findAll();
    notifyListeners();
  }

  Future<void> delete(Address address) async {
    await service.delete(address.zipCode);
    value.removeWhere((element) => element.id == address.id);
    notifyListeners();
  }

  Future<void> create(Address address) async {
    await service.create(address);
    return findAll();
  }

  Future<void> update(Address address) async {
    final newAddress = await service.update(address);
    value.removeWhere((element) => element.id == address.id);
    value.add(newAddress);
    notifyListeners();
  }
}
