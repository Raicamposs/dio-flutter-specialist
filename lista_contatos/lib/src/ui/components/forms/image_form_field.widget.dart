import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class AvatarFormField extends StatefulWidget {
  const AvatarFormField({
    Key? key,
    this.onSaved,
    this.validator,
    this.initialValue,
  }) : super(key: key);

  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String? initialValue;

  @override
  State<AvatarFormField> createState() => _AvatarFormFieldState();
}

class _AvatarFormFieldState extends State<AvatarFormField> {
  _pickerImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    return _saveImageInApplicationDirectory(photo);
  }

  _openCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    return _saveImageInApplicationDirectory(photo);
  }

  _saveImageInApplicationDirectory(XFile? photo) async {
    if (photo == null) return null;

    final directory = await getApplicationDocumentsDirectory();
    final fileExtension = photo.name.split('.').last;
    final newPath = '${directory.path}/${const Uuid().v4()}.$fileExtension';
    await photo.saveTo(newPath);
    return newPath;
  }

  bool openMenu = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: FormField<String?>(
          initialValue: widget.initialValue,
          onSaved: widget.onSaved,
          validator: widget.validator,
          builder: (FormFieldState<String?> state) {
            final pickedFile = File(state.value ?? '');

            return Container(
              color: Colors.transparent,
              width: 150,
              height: 110,
              child: Stack(
                children: [
                  FutureBuilder<bool>(
                      future: pickedFile.exists(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox.shrink();
                        }

                        return ClipOval(
                          child: GestureDetector(
                            onTap: () async {
                              if (Platform.isAndroid || Platform.isIOS) {
                                setState(() {
                                  openMenu = !openMenu;
                                });
                                return;
                              }

                              await _pickerImage().then(
                                (path) => state.didChange(path),
                              );
                            },
                            child: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).primaryColorDark,
                              radius: 50,
                              backgroundImage:
                                  snapshot.data! ? FileImage(pickedFile) : null,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor:
                                    Colors.black12.withOpacity(0.1),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(right: 8, left: 8),
                                      child: Icon(
                                        Icons.add_a_photo_outlined,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                    Visibility(
                                      visible: snapshot.data!,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                        onPressed: () {
                                          state.didChange(null);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                  Align(
                    alignment: Alignment.topRight,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: openMenu ? 1 : 0,
                      child: IconButton.filledTonal(
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                        ),
                        onPressed: () => _openCamera()
                            .then(
                              (path) => state.didChange(path),
                            )
                            .whenComplete(
                              () => setState(() => openMenu = false),
                            ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: openMenu ? 1 : 0,
                      child: IconButton.filledTonal(
                        icon: const Icon(
                          Icons.image_outlined,
                        ),
                        onPressed: () => _pickerImage()
                            .then(
                              (path) => state.didChange(path),
                            )
                            .whenComplete(
                              () => setState(() => openMenu = false),
                            ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
