import 'package:flutter/material.dart';
import 'package:lista_contatos/src/presentation/dtos/user-form.dart';
import 'package:lista_contatos/src/presentation/factories/controllers/form_controller.factory.dart';
import 'package:lista_contatos/src/ui/common/validators.dart';
import 'package:lista_contatos/src/ui/components/forms/date_picker_form_field.widget.dart';
import 'package:lista_contatos/src/ui/components/forms/form_containe.widget.dart';
import 'package:lista_contatos/src/ui/components/forms/phone_form_field.widget.dart';

import '../../../presentation/controllers/index.dart';
import '../../components/forms/email_list_form_field.widget.dart';
import 'components/header.widget.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key, required this.controller, this.data})
      : super(key: key);

  final IFormController controller;
  final UserForm? data;

  factory FormPage.fromArgs(BuildContext context, {Key? key}) {
    return FormPage(
      key: key,
      controller: makeFormController(),
      data: ModalRoute.of(context)?.settings.arguments as UserForm?,
    );
  }

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final formKey = GlobalKey<FormState>();
  final formValues = <String, dynamic>{};

  _onSaved(String key) {
    return (value) {
      formValues[key] = value;
    };
  }

  _initialValue(String key) {
    return formValues[key];
  }

  Future<bool> _onSubmit() async {
    if (!formKey.currentState!.validate()) return false;

    formKey.currentState?.save();
    final data = UserForm.fromMap(formValues);
    await widget.controller.save(data);
    return true;
  }

  @override
  void initState() {
    if (widget.data != null) {
      formValues.addAll(widget.data!.toMap());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormContainer(
        id: formKey,
        children: [
          HeaderWidget(
            heroTag: widget.data?.id ?? 'new',
            onSavedPhoto: _onSaved('photo'),
            initialValue: _initialValue('photo'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              initialValue: _initialValue('name'),
              onSaved: _onSaved('name'),
              validator: Validators.init()
                  .required('Nome obrigatório')
                  .minLength(3, 'Nome deve ter ao menos 3 caracteres')
                  .build(),
              decoration: const InputDecoration(
                labelText: 'Nome',
                prefixIcon: Icon(Icons.account_circle),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              initialValue: _initialValue('jobTitle'),
              onSaved: _onSaved('jobTitle'),
              decoration: const InputDecoration(
                labelText: 'Profissão',
                prefixIcon: Icon(Icons.work),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              initialValue: _initialValue('company'),
              onSaved: _onSaved('company'),
              decoration: const InputDecoration(
                labelText: 'Empresa',
                prefixIcon: Icon(Icons.apartment),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: EmailListFormField(
              initialValue: _initialValue('emails'),
              onSaved: _onSaved('emails'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: PhoneListFormField(
              initialValue: _initialValue('phones'),
              onSaved: _onSaved('phones'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              initialValue: _initialValue('address'),
              onSaved: _onSaved('address'),
              decoration: const InputDecoration(
                labelText: 'Endereço',
                prefixIcon: Icon(Icons.pin_drop_rounded),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: DatePickerFormField(
              initialValue: _initialValue('birthday'),
              onSaved: _onSaved('birthday'),
              decoration: const InputDecoration(
                labelText: 'Aniversário',
              ),
              icon: const Icon(Icons.cake),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              initialValue: _initialValue('notes'),
              onSaved: _onSaved('notes'),
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Observações',
                prefixIcon: Icon(Icons.format_align_left_outlined),
                hintText: 'Escreva aqui suas observações',
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
      persistentFooterButtons: [
        Visibility(
          visible: widget.data != null,
          child: SizedBox(
            height: 40,
            width: 120,
            child: TextButton(
              onPressed: () async {
                await widget.controller.delete(widget.data?.id ?? '');
                Navigator.pop(context);
              },
              child: const Text('Remover', style: TextStyle(color: Colors.red)),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          width: 120,
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
        ),
        SizedBox(
          height: 40,
          width: 120,
          child: FilledButton(
            onPressed: () => _onSubmit().then((value) {
              if (value) Navigator.pop(context);
            }),
            child: const Text('Salvar'),
          ),
        ),
      ],
    );
  }
}
