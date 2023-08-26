import 'dart:async';

import 'package:app_calculadora_imc/src/domain/entities/history.dart';
import 'package:app_calculadora_imc/src/domain/services/history.service.dart';

class HistoryController {
  final HistoryService _service;

  late StreamController<List<History>> _controller;

  HistoryController({required HistoryService service}) : _service = service {
    _controller = StreamController();
  }

  Stream<List<History>> get stream => _controller.stream;

  Future<void> reload() async {
    final items = await _service.listAll();

    _controller.add(items);
  }

  dispose() {
    _controller.close();
  }
}
