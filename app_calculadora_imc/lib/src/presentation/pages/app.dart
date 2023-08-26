import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../style/index.dart';
import 'index.dart';

class CalculadoraImcApp extends StatelessWidget {
  const CalculadoraImcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      color: appTheme.primaryColor,
      theme: appTheme,
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initialRoute,
      routes: {
        AppRoutes.home: (context) => HomePage.fromArgs(context),
        AppRoutes.imcForm: (context) => ImcFormPage.fromArgs(context),
        AppRoutes.status: (context) => StatusPage.fromArgs(context),
        AppRoutes.history: (context) => HistoryPage.fromArgs(context),
      },
    );
  }
}
