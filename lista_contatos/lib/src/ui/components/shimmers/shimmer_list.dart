import 'package:flutter/material.dart';

import '../../common/animations/shimmer.dart';

class ShimmerList extends StatelessWidget {
  const ShimmerList({Key? key, required this.itemCount}) : super(key: key);
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (_, __) => Shimmer.textEdit(),
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemCount: itemCount,
    );
  }
}
