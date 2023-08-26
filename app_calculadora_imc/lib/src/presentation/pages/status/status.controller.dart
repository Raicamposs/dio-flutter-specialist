import 'package:app_calculadora_imc/src/domain/entities/history.dart';
import 'package:app_calculadora_imc/src/domain/services/history.service.dart';

class StatusController {
  final HistoryService _service;

  StatusController({required HistoryService service}) : _service = service;

  Future<void> save(History data) async {
    await _service.save(data);
  }

  dispose() {}
}
