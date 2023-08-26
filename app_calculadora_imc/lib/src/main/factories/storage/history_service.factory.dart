import 'package:app_calculadora_imc/src/data/implementations/history-hive.service.dart';
import 'package:app_calculadora_imc/src/domain/services/history.service.dart';

HistoryService makeHistoryService() => HistoryHiveService();
