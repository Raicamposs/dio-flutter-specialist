import '../entities/history.dart';

abstract class HistoryService {
  Future<List<History>> listAll({int? limit, int? offset});
  Future<void> save(History history);
  Future<History> findLast();
}
