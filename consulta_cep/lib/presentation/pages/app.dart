import 'package:consulta_cep/presentation/pages/home.page.dart';
import 'package:flutter/material.dart';

class ConsultaCepApp extends StatelessWidget {
  const ConsultaCepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consulta CEP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
