import 'package:app_calculadora_imc/src/presentation/pages/home/home.controller.dart';

import '../storage/history_service.factory.dart';

HomeController makeHomeController() =>
    HomeController(service: makeHistoryService());
