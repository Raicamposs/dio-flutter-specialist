import 'package:flutter/material.dart';

class FormContainer extends StatelessWidget {
  final GlobalKey<FormState> id;
  final List<Widget> children;

  const FormContainer({super.key, required this.id, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 200, minHeight: 200),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: id,
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: children.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 8);
            },
            itemBuilder: (BuildContext context, int index) {
              return children[index];
            },
          ),
        ),
      ),
    );
  }
}
