// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_contatos/src/ui/common/validators.dart';

import '../../common/debounce.dart';
import '../formatter/phone_input_formatter.dart';

class PhoneListFormField extends StatefulWidget {
  const PhoneListFormField({
    Key? key,
    this.onSaved,
    this.initialValue,
  }) : super(key: key);

  final List<PhoneData>? initialValue;
  final FormFieldSetter<List<PhoneData>>? onSaved;

  @override
  State<PhoneListFormField> createState() => _PhoneListFormFieldState();
}

class _PhoneListFormFieldState extends State<PhoneListFormField> {
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

  _phoneValidator(PhoneData? phone) {
    return Validators.init()
        .required('Telefone deve ser preenchido')
        .phone('Telefone inválido')
        .build()(phone?.number);
  }

  get _initialValue {
    if (widget.initialValue?.isEmpty ?? true) {
      return [PhoneData.empty()];
    }

    return widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: FormField<List<PhoneData>?>(
          initialValue: _initialValue,
          onSaved: (value) {
            final onlyValidPhones = value
                ?.where((element) => element.number.trim().isNotEmpty)
                .toList();
            widget.onSaved?.call(onlyValidPhones);
          },
          validator: (List<PhoneData>? data) {
            if (data == null || data.isEmpty) {
              return null;
            }

            Validators validator = Validators.init().phone('Telefone inválido');

            if (data.length == 1 && data.first.label.trim().isNotEmpty) {
              validator = validator.required('Telefone deve ser preenchido');
            }

            if (data.length > 1) {
              validator = validator.required('Telefone deve ser preenchido');
            }

            return data
                .map((phone) => validator.build()(phone.number))
                .toList()
                .firstWhere((element) => element != null, orElse: () => null);
          },
          builder: (FormFieldState<List<PhoneData>?> state) {
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
                            initialValue: e.number,
                            onChanged: (value) {
                              _debounce(() {
                                final index = state.value!.indexOf(e);
                                final phones = [...state.value!];
                                phones.removeAt(index);
                                phones.insert(
                                  index,
                                  e.copyWith(number: value),
                                );
                                state.didChange(phones);
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Telefone',
                              prefixIcon: const Icon(Icons.phone),
                              errorText:
                                  state.hasError ? _phoneValidator(e) : null,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              PhoneInputFormatter(),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextFormField(
                            initialValue: e.label,
                            onChanged: (value) {
                              _debounce(() {
                                final index = state.value!.indexOf(e);
                                final phones = [...state.value!];
                                phones.removeAt(index);
                                phones.insert(
                                  index,
                                  e.copyWith(label: value),
                                );
                                state.didChange(phones);
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
                                final phones = [...state.value!];
                                phones.removeAt(index);
                                state.didChange(phones);
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
                      PhoneData.empty(),
                    ]);
                  },
                  icon: const Icon(Icons.add_circle),
                  label: const Text('Adicionar um número de telefone'),
                )
              ],
            );
          }),
    );
  }
}

class PhoneData {
  final String number;
  final String label;

  PhoneData({required this.number, this.label = ''});

  factory PhoneData.empty() {
    return PhoneData(
      number: '',
      label: '',
    );
  }

  PhoneData copyWith({
    String? number,
    String? label,
  }) {
    return PhoneData(
      number: number ?? this.number,
      label: label ?? this.label,
    );
  }

  @override
  String toString() => 'Phone($number, $label)';
}
