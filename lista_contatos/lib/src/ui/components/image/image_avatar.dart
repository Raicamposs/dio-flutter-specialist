import 'dart:io';

import 'package:flutter/material.dart';

import '../../common/animations/shimmer.dart';

class ImageAvatar extends StatelessWidget {
  const ImageAvatar({
    Key? key,
    required this.imageUrl,
    this.radius = 25,
    this.icon,
    required this.semanticLabel,
  }) : super(key: key);

  final String? imageUrl;
  final String semanticLabel;
  final double radius;
  final IconData? icon;

  Widget _placeholderBuilder(_, __, ___) {
    return Shimmer.circleAvatar(radius);
  }

  Widget _imageBuilder(BuildContext context, Image image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CircleAvatar(
        radius: radius,
        child: image,
      ),
    );
  }

  Widget _emptyUrlBuilder(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      // backgroundColor: const Color.fromRGBO(189, 189, 189, 1),
      child: LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          return Icon(
            Icons.person,
            size: radius * 0.8,
            color: Theme.of(context).primaryColorDark,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return _emptyUrlBuilder(context);
    }

    if (imageUrl!.isEmpty) {
      return _emptyUrlBuilder(context);
    }

    if (imageUrl!.startsWith('http')) {
      return _imageBuilder(
        context,
        Image.network(
          imageUrl!,
          loadingBuilder: _placeholderBuilder,
          fit: BoxFit.cover,
          width: radius * 2,
          height: radius * 2,
          errorBuilder: (_, __, ___) => _emptyUrlBuilder(context),
        ),
      );
    }

    if (File(imageUrl!).existsSync()) {
      return _imageBuilder(
        context,
        Image.file(
          File(imageUrl!),
          semanticLabel: semanticLabel,
          fit: BoxFit.cover,
          width: radius * 2,
          height: radius * 2,
          errorBuilder: (_, __, ___) => _emptyUrlBuilder(context),
        ),
      );
    }

    return _imageBuilder(
      context,
      Image.asset(
        imageUrl!,
        fit: BoxFit.cover,
        width: radius * 2,
        height: radius * 2,
        errorBuilder: (_, __, ___) => _emptyUrlBuilder(context),
      ),
    );
  }
}
