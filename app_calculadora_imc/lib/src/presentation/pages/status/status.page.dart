import 'package:app_calculadora_imc/src/domain/entities/history.dart';
import 'package:app_calculadora_imc/src/main/factories/controllers/status_controller.factory.dart';
import 'package:app_calculadora_imc/src/presentation/pages/status/status.controller.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/imc.dart';
import 'components/legend.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key, required this.imc, required this.controller})
      : super(key: key);

  final Imc imc;
  final StatusController controller;

  factory StatusPage.fromArgs(BuildContext context, {Key? key}) {
    final args =
        (ModalRoute.of(context)!.settings.arguments) as Map<String, dynamic>;

    return StatusPage(
      key: key,
      controller: makeStatusController(),
      imc: Imc(
        height: args['height']!,
        weight: args['weight']!,
      ),
    );
  }

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  Future<void> _submit() async {
    return widget.controller
        .save(History(
          id: UniqueKey().toString(),
          imc: widget.imc.value,
          height: widget.imc.height,
          weight: widget.imc.weight,
          date: DateTime.now(),
        ))
        .whenComplete(() => Navigator.pop(context));
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Resultado'),
      ),
      body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: _Card(
                    title: 'Peso (Kg):',
                    value: widget.imc.weightFormatted,
                  ),
                ),
                Expanded(
                  child: _Card(
                    title: 'Altura (M):',
                    value: widget.imc.heightFormatted,
                  ),
                ),
              ],
            ),
            _Card(
              title: 'IMC:',
              value: widget.imc.valueFormatted,
            ),
            const SizedBox(height: 32),
            ...widget.imc.data.entries
                .map(
                  (item) => LegendWidget(
                    color: Color(item.value.color),
                    text: item.key,
                    range: item.value.range,
                    selected: item.key == widget.imc.status,
                  ),
                )
                .toList(),
          ]),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 50,
          margin: const EdgeInsets.only(
            bottom: 24,
            left: 16,
            right: 16,
          ),
          child: FilledButton(
            onPressed: _submit,
            child: const Text('Salvar'),
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({Key? key, required this.title, required this.value})
      : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(
              title,
              textAlign: TextAlign.justify,
              style: textTheme.labelSmall,
            ),
            const SizedBox(height: 16),
            AutoSizeText(
              value,
              textAlign: TextAlign.center,
              style: textTheme.displaySmall?.copyWith(
                color: theme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
