import 'package:consulta_cep/domain/entities/address.entity.dart';
import 'package:consulta_cep/presentation/common/validators.dart';
import 'package:consulta_cep/presentation/components/form_container.dart';
import 'package:flutter/material.dart';

const Map<String, String> _labels = {
  'zipCode': 'CEP',
  'street': 'Rua',
  'number': 'Número',
  'complement': 'Complemento',
  'district': 'Bairro',
  'city': 'Cidade',
  'state': 'Estado',
  'ibge': 'IBGE',
  'gia': 'GIA',
  'ddd': 'DDD',
  'siafi': 'SIAFI',
  'neighborhood': 'Bairro',
  'locality': 'Localidade',
  'uf': 'UF',
};

Map<String, FormFieldValidator<String>?> _validator = {
  'zipCode': Validators.init()
      .required('O CEP é obrigatório')
      .length(9, 'O CEP deve ter 9 dígitos')
      .build(),
  'uf': Validators.init()
      .justLetters('UF deve conter apenas letras')
      .length(2, 'UF deve ter 2 dígitos')
      .build(),
  'street': Validators.init().required('Rua é obrigatório').build(),
  'ibge': Validators.init().number('IBGE deve ser um número').build(),
  'gia': Validators.init().number('GIA deve ser um número').build(),
  'ddd': Validators.init()
      .number('DDD deve ser um número')
      .length(2, 'DDD deve ter 2 dígitos')
      .build(),
};

class FormPage extends StatefulWidget {
  const FormPage({
    super.key,
    this.address,
  });

  final Address? address;

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  late Map<String, dynamic> _formValues;
  final GlobalKey<FormState> _formId = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final Address address = widget.address ?? Address.blank();
    _formValues = address.toMap();
  }

  @override
  void dispose() {
    _formId.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Cadastro'),
        centerTitle: true,
      ),
      body: FormContainer(
        id: _formId,
        children: _formValues.keys
            .where((element) => !['id'].contains(element))
            .map((key) {
          return TextFormField(
            initialValue: _formValues[key],
            validator: _validator[key],
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: _labels[key] ?? key,
            ),
            onChanged: (value) => _formValues[key] = value,
          );
        }).toList(),
      ),
      bottomNavigationBar: SafeArea(
          child: Container(
        height: 50,
        margin: const EdgeInsets.only(
          bottom: 24,
          left: 16,
          right: 16,
        ),
        child: FilledButton(
          onPressed: () {
            if (_formId.currentState!.validate()) {
              Navigator.pop(context, Address.fromMap(_formValues));
            }
          },
          child: const Text('Salvar'),
        ),
      )),
    );
  }
}
