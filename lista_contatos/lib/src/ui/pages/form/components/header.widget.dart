import 'package:flutter/material.dart';
import 'package:lista_contatos/src/ui/components/forms/image_form_field.widget.dart';

class HeaderWidget extends StatelessWidget {
  final void Function(String?)? onSavedPhoto;
  final String? initialValue;
  final String heroTag;

  const HeaderWidget({
    super.key,
    required this.onSavedPhoto,
    this.initialValue,
    this.heroTag = 'avatar',
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 180,
        child: Stack(
          fit: StackFit.expand,
          children: [
            FractionallySizedBox(
              heightFactor: 0.6,
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColorDark
                    ],
                  ),
                ),
              ),
            ),
            const FractionallySizedBox(
              heightFactor: 0.2,
              alignment: Alignment.bottomCenter,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 24, top: 30),
                child: Hero(
                  tag: heroTag,
                  child: AvatarFormField(
                    onSaved: onSavedPhoto,
                    initialValue: initialValue,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
