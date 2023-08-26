import 'package:app_calculadora_imc/src/domain/entities/history.dart';
import 'package:app_calculadora_imc/src/presentation/components/form_container.dart';
import 'package:app_calculadora_imc/src/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import '../common/input_formatters/decimal_input_format.dart';
import '../common/validators.dart';
import '../components/resized_box.dart';

class ImcFormPage extends StatefulWidget {
  const ImcFormPage({Key? key, this.lastHistory}) : super(key: key);
  final History? lastHistory;

  factory ImcFormPage.fromArgs(BuildContext context, {Key? key}) {
    final History? args =
        (ModalRoute.of(context)!.settings.arguments) as History?;

    return ImcFormPage(
      key: key,
      lastHistory: args,
    );
  }

  @override
  State<ImcFormPage> createState() => _ImcFormPageState();
}

class _ImcFormPageState extends State<ImcFormPage> {
  final GlobalKey<FormState> _formId = GlobalKey<FormState>();
  late FocusNode _nodeWeight;
  late FocusNode _nodeHeight;

  TextEditingController? _controllerWeight;
  TextEditingController? _controllerHeight;

  final _formValues = <String, double>{
    'weight': 0,
    'height': 0,
  };

  @override
  void initState() {
    super.initState();
    _nodeWeight = FocusNode();
    _nodeHeight = FocusNode();

    _controllerWeight = TextEditingController(
      text: widget.lastHistory?.weight.toString().replaceAll('.', ',') ?? '',
    );

    _controllerHeight = TextEditingController(
      text: widget.lastHistory?.height.toString().replaceAll('.', ',') ?? '',
    );

    _nodeWeight.requestFocus();
  }

  @override
  void dispose() {
    _nodeWeight.dispose();
    _nodeHeight.dispose();
    _controllerWeight?.dispose();
    _controllerHeight?.dispose();
    _formId.currentState?.dispose();
    super.dispose();
  }

  _onSubmit() {
    if (!(_formId.currentState?.validate() ?? false)) {
      _nodeWeight.requestFocus();
      return;
    }

    _formId.currentState?.save();
    Navigator.of(context)
        .pushNamed(
          AppRoutes.status,
          arguments: _formValues,
        )
        .whenComplete(() => Navigator.of(context).pop());
  }

  _onReset() {
    _formId.currentState?.reset();
    _controllerWeight?.clear();
    _controllerHeight?.clear();
  }

  _onSave(String key) {
    return (String? value) {
      final doubleFormat = value.toString().replaceAll(',', '.');
      final parsedValue = double.tryParse(doubleFormat) ?? 0.0;
      _formValues.update(key, (value) => parsedValue);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calcule seu IMC'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormContainer(id: _formId, children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.4,
            child: Hero(
              tag: 'image',
              child: Lottie.asset('assets/animations/balanca.json'),
            ),
          ),
          TextFormField(
            focusNode: _nodeWeight,
            controller: _controllerWeight,
            onFieldSubmitted: (_) => _nodeHeight.requestFocus(),
            decoration: const InputDecoration(
              labelText: 'Peso (kg)',
              hintText: 'Informe seu peso',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
              DecimalInputFormatter(decimalDigits: 2),
            ],
            textInputAction: TextInputAction.next,
            onSaved: _onSave('weight'),
            validator: Validators.init()
                .required('Informe seu peso')
                .min(0.1, 'Informe um peso válido')
                .max(300, 'Informe um peso válido')
                .build(),
          ),
          const SizedBox(height: 8),
          TextFormField(
            focusNode: _nodeHeight,
            controller: _controllerHeight,
            decoration: const InputDecoration(
              labelText: 'Altura (m)',
              hintText: 'Informe sua altura',
            ),
            onFieldSubmitted: (_) => _onSubmit(),
            textInputAction: TextInputAction.done,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
              DecimalInputFormatter(decimalDigits: 2),
            ],
            onSaved: _onSave('height'),
            validator: Validators.init()
                .required('Informe sua altura')
                .min(0.1, 'Informe uma altura válida')
                .max(3, 'Informe uma altura válida')
                .build(),
          ),
          const SizedBox(height: 24),
        ]),
      ),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: [
        ResizedBox(
          widthFactor: 45,
          maxWidth: 250,
          minWidth: 150,
          child: OutlinedButton(
            onPressed: _onReset,
            child: const Text('Limpar'),
          ),
        ),
        ResizedBox(
          widthFactor: 45,
          maxWidth: 250,
          minWidth: 150,
          child: FilledButton(
            onPressed: _onSubmit,
            child: const Text('Calcular'),
          ),
        ),
      ],
    );
  }
}
