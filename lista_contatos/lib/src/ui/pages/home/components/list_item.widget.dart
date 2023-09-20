import 'package:flutter/material.dart';
import 'package:lista_contatos/src/presentation/dtos/user-list.dart';
import 'package:lista_contatos/src/ui/components/image/image_avatar.dart';

class ListItemWidget extends StatelessWidget {
  final UserList data;
  final void Function(UserList data)? onTap;

  const ListItemWidget({super.key, required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      leading: Hero(
        tag: 'view_${data.id}',
        child: ImageAvatar(
          imageUrl: data.photo,
          semanticLabel: data.title,
        ),
      ),
      title: Text(
        data.title,
        style: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        data.subtitle,
        style: textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: () => onTap?.call(data),
    );
  }
}
