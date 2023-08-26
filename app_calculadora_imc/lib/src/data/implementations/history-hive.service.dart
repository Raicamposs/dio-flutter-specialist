import 'dart:io';

import 'package:app_calculadora_imc/src/domain/entities/history.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/services/history.service.dart';

class HistoryHiveService extends HistoryService {
  bool _tryFixDB = false;

  @override
  Future<List<History>> listAll({int? limit, int? offset}) async {
    final box = await _box;

    final output = limit == null ? box.values : box.values.take(limit);

    final histories = output.map((item) => History.fromJson(item)).toList();
    histories.sort((a, b) => b.date.compareTo(a.date));
    histories.reversed;

    return histories;
  }

  @override
  Future<void> save(History history) async {
    final box = await _box;
    return box.put(history.id, history.toJson());
  }

  @override
  Future<History> findLast() async {
    final box = await _box;
    final output = box.values.map((item) => History.fromJson(item)).toList();
    output.sort((a, b) => b.date.compareTo(a.date));
    return output.last;
  }

  Future<Box<String>> get _box async {
    try {
      if (Hive.isBoxOpen('history')) {
        return Future.value(Hive.box('history'));
      }
      // await _deleteDatabaseFiles();
      return Hive.openBox('history');
    } catch (_) {
      if (!_tryFixDB) {
        _tryFixDB = true;
        await _deleteDatabaseFiles();
        return await _box;
      }
      rethrow;
    }
  }

  Future<void> _deleteDatabaseFiles() async {
    var dir = await getApplicationDocumentsDirectory();
    String dirPath = dir.path;

    File dbFile = File('$dirPath/history.hive');
    File lockFile = File('$dirPath/history.lock');

    await Future.wait([
      dbFile.exists().then((value) async {
        if (value) {
          await dbFile.delete();
        }
      }),
      lockFile.exists().then((value) async {
        if (value) {
          await lockFile.delete();
        }
      }),
    ]);
  }
}
