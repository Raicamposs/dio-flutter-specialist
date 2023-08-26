import 'package:app_calculadora_imc/src/domain/entities/history.dart';

import '../../domain/services/history.service.dart';

class HistoryInMemoryService extends HistoryService {
  final List<History> _history = [];

  static final HistoryInMemoryService _instance = HistoryInMemoryService._();

  HistoryInMemoryService._();

  factory HistoryInMemoryService() {
    return _instance;
  }

  @override
  Future<List<History>> listAll({int? limit, int? offset}) {
    return Future.delayed(const Duration(milliseconds: 500)).then((value) {
      if (limit != null) {
        return _history.take(limit).toList();
      }
      return _history;
    });
  }

  @override
  Future<void> save(History history) {
    return Future.delayed(const Duration(milliseconds: 500)).then((value) {
      _history.add(history);
    });
  }

  @override
  Future<History> findLast() {
    _history.sort((a, b) => b.date.compareTo(a.date));
    final last = _history.last;
    return Future.delayed(const Duration(milliseconds: 500))
        .then((value) => last);
  }
}
