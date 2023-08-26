import 'dart:async';

import 'package:app_calculadora_imc/src/domain/entities/history.dart';
import 'package:app_calculadora_imc/src/domain/services/history.service.dart';
import 'package:rxdart/rxdart.dart';

class HomeController {
  final HistoryService _service;

  History? _lastHistory;

  late BehaviorSubject<List<History>> _controller;

  HomeController({required HistoryService service}) : _service = service {
    _controller = BehaviorSubject();
    reload();
  }

  History? get lastHistory => _lastHistory;
  Stream<List<History>> get stream => _controller.stream;
  Stream<History?> get lastHistoryStream => _controller.map((event) {
        if (event.isEmpty) return null;
        return event.first;
      });

  Future<void> reload() async {
    final histories = await _service.listAll(limit: 4);

    if (histories.isEmpty) {
      _lastHistory = null;
      _controller.add([]);
      return;
    }

    _lastHistory = histories.first;
    _controller.add(histories);
  }

  dispose() {
    _controller.close();
  }
}
