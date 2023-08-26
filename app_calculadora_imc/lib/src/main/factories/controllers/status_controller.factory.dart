import 'package:app_calculadora_imc/src/presentation/pages/status/status.controller.dart';

import '../storage/history_service.factory.dart';

StatusController makeStatusController() =>
    StatusController(service: makeHistoryService());
