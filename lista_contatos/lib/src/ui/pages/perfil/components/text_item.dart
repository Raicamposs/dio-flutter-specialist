import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextItem extends StatelessWidget {
  final IconData icon;
  final String? title;

  const TextItem({super.key, required this.icon, this.title});

  factory TextItem.date({
    required IconData icon,
    DateTime? date,
  }) {
    final dateFormat = DateFormat('dd/MM/yyyy');

    return TextItem(
      icon: Icons.date_range,
      title: date == null ? null : dateFormat.format(date),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: title?.trim().isNotEmpty ?? false,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title ?? ''),
      ),
    );
  }
}
