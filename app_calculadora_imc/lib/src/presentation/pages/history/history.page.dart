import 'package:app_calculadora_imc/src/domain/entities/history.dart';
import 'package:app_calculadora_imc/src/main/factories/controllers/history_controller.factory.dart';
import 'package:app_calculadora_imc/src/presentation/pages/history/history.controller.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key, required this.controller}) : super(key: key);

  final HistoryController controller;

  factory HistoryPage.fromArgs(BuildContext context, {Key? key}) {
    return HistoryPage(
      key: key,
      controller: makeHistoryController(),
    );
  }

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    widget.controller.reload();
    super.initState();
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
        title: const Text('Histórico'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<History>>(
          stream: widget.controller.stream,
          initialData: const [],
          builder: (_, snapshot) {
            return Center(
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Data',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Peso',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'IMC',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ],
                rows: snapshot.data!
                    .map(
                      (e) => DataRow(
                        cells: <DataCell>[
                          DataCell(Text(e.dateFormatted)),
                          DataCell(Text(e.weightFormatted)),
                          DataCell(Text(e.imcFormatted)),
                        ],
                      ),
                    )
                    .toList(),
              ),
            );
          },
        ),
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
            onPressed: () => Navigator.pop(context),
            child: const Text('Voltar'),
          ),
        ),
      ),
    );
  }
}
