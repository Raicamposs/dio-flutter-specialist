import 'package:flutter/material.dart';

class FormContainer extends StatelessWidget {
  final GlobalKey<FormState> id;
  final List<Widget> children;
  final IndexedWidgetBuilder? separatorBuilder;
  final EdgeInsetsGeometry? padding;

  const FormContainer({
    super.key,
    required this.id,
    required this.children,
    this.separatorBuilder,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 200, minHeight: 200),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: id,
          child: ListView.separated(
            padding: padding,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: children.length,
            separatorBuilder: separatorBuilder ??
                (_, int index) => const SizedBox(height: 14),
            itemBuilder: (BuildContext context, int index) {
              return children[index];
            },
          ),
        ),
      ),
    );
  }
}
