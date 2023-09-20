import 'package:flutter/material.dart';
import 'package:lista_contatos/src/ui/pages/perfil/components/index.dart';

class TextListItem extends StatelessWidget {
  final IconData icon;
  final List<(String value, String label)>? data;

  const TextListItem({super.key, required this.icon, this.data = const []});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: data?.isNotEmpty ?? false,
      child: ListTile(
        leading: Icon(icon),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: (data ?? [])
              .map((e) => TextWithLabel(text: e.$1, label: e.$2))
              .toList(),
        ),
      ),
    );
  }
}
