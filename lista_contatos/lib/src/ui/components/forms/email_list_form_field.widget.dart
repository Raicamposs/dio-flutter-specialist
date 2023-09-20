// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lista_contatos/src/ui/common/validators.dart';

import '../../common/debounce.dart';

class EmailListFormField extends StatefulWidget {
  const EmailListFormField({
    Key? key,
    this.onSaved,
    this.initialValue,
  }) : super(key: key);

  final List<EmailData>? initialValue;
  final FormFieldSetter<List<EmailData>>? onSaved;

  @override
  State<EmailListFormField> createState() => _EmailListFormFieldState();
}

class _EmailListFormFieldState extends State<EmailListFormField> {
  late Debounce _debounce;

  @override
  void initState() {
    _debounce = Debounce(const Duration(milliseconds: 400));
    super.initState();
  }

  @override
  void dispose() {
    _debounce.dispose();
    super.dispose();
  }

  _emailValidator(EmailData? input) {
    return Validators.init()
        .required('Email deve ser preenchido')
        .email('Email inválido')
        .build()(input?.email);
  }

  get _initialValue {
    if (widget.initialValue?.isEmpty ?? true) {
      return [EmailData.empty()];
    }

    return widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: FormField<List<EmailData>?>(
          initialValue: _initialValue,
          onSaved: (value) {
            final onlyValidEmails = value
                ?.where((element) => element.email.trim().isNotEmpty)
                .toList();

            widget.onSaved?.call(onlyValidEmails);
          },
          validator: (List<EmailData>? data) {
            if (data == null || data.isEmpty) {
              return null;
            }

            Validators validator = Validators.init().email('Email inválido');

            if (data.length == 1 && data.first.label.trim().isNotEmpty) {
              validator = validator.required('Email deve ser preenchido');
            }

            if (data.length > 1) {
              validator = validator.required('Email deve ser preenchido');
            }

            return data
                .map((item) => validator.build()(item.email))
                .toList()
                .firstWhere((element) => element != null, orElse: () => null);
          },
          builder: (FormFieldState<List<EmailData>?> state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ...(state.value ?? []).map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            initialValue: e.email,
                            onChanged: (value) {
                              _debounce(() {
                                final index = state.value!.indexOf(e);
                                final emails = [...state.value!];
                                emails.removeAt(index);
                                emails.insert(
                                  index,
                                  e.copyWith(email: value),
                                );
                                state.didChange(emails);
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: const Icon(Icons.mail),
                              errorText:
                                  state.hasError ? _emailValidator(e) : null,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextFormField(
                            initialValue: e.label,
                            onChanged: (value) {
                              _debounce(() {
                                final index = state.value!.indexOf(e);
                                final emails = [...state.value!];
                                emails.removeAt(index);
                                emails.insert(
                                  index,
                                  e.copyWith(label: value),
                                );
                                state.didChange(emails);
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'Label',
                              prefixIcon: Icon(Icons.sell),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: (state.value ?? []).length > 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: IconButton(
                              onPressed: () {
                                final index = state.value!.indexOf(e);
                                final emails = [...state.value!];
                                emails.removeAt(index);
                                state.didChange(emails);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    state.didChange([
                      ...state.value ?? [],
                      EmailData.empty(),
                    ]);
                  },
                  icon: const Icon(Icons.add_circle),
                  label: const Text('Adicionar um email'),
                ),
              ],
            );
          }),
    );
  }
}

class EmailData {
  final String email;
  final String label;

  EmailData({required this.email, this.label = ''});

  factory EmailData.empty() {
    return EmailData(
      email: '',
      label: '',
    );
  }

  EmailData copyWith({
    String? email,
    String? label,
  }) {
    return EmailData(
      email: email ?? this.email,
      label: label ?? this.label,
    );
  }

  @override
  String toString() => 'Email($email, $label)';
}
