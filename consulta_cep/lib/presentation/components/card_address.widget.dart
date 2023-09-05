import 'package:consulta_cep/domain/entities/address.entity.dart';
import 'package:flutter/material.dart';

class CardAddress extends StatelessWidget {
  const CardAddress(
      {Key? key, required this.address, this.onDelete, this.onUpdate})
      : super(key: key);
  final Address address;
  final void Function(Address)? onDelete;
  final void Function(Address)? onUpdate;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onUpdate?.call(address),
      leading: const Icon(Icons.location_on),
      title: Text(address.zipCode),
      subtitle: Text(address.description),
      trailing: IconButton(
        onPressed: () => onDelete?.call(address),
        icon: const Icon(Icons.delete),
      ),
    );
  }
}
