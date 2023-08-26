import 'package:app_calculadora_imc/src/presentation/pages/history/history.controller.dart';

import '../storage/history_service.factory.dart';

HistoryController makeHistoryController() =>
    HistoryController(service: makeHistoryService());
