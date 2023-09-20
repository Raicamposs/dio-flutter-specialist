import 'package:flutter/material.dart';
import 'package:lista_contatos/src/ui/pages/form/form.page.dart';
import 'package:lista_contatos/src/ui/pages/perfil/perfil.page.dart';

import '../routes/app_routes.dart';
import '../style/index.dart';
import 'index.dart';

class CalculadoraImcApp extends StatelessWidget {
  const CalculadoraImcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Contatos',
      color: appTheme.primaryColor,
      theme: appTheme,
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initialRoute,
      routes: {
        AppRoutes.home: (context) => HomePage.fromArgs(context),
        AppRoutes.perfil: (context) => PerfilPage.fromArgs(context),
        AppRoutes.form: (context) => FormPage.fromArgs(context),
      },
    );
  }
}
