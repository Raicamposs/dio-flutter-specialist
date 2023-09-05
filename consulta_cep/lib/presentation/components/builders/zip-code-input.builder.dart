import 'package:consulta_cep/presentation/common/input_formatters/zip_code_input_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ZipCodeInputBuilder {
  static Future<String?> show(BuildContext context) async {
    final controller = TextEditingController();
    return showModalBottomSheet<String?>(
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Informe o CEP',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      ZipCodeInputFormatter(),
                    ],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'CEP',
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                    width: double.infinity,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.of(context).pop(controller.text);
                        controller.dispose();
                      },
                      child: const Text('Buscar'),
                    ),
                  )
                ]),
          );
        });
  }
}
