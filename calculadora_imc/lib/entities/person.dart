import 'imc.dart';

class Person {
  final String name;
  final double height;
  final double weight;
  final Imc _imc;

  Person({
    required this.name,
    required this.height,
    required this.weight,
  }) : _imc = Imc(height: height, weight: weight);

  String get status => _imc.status;
  String get imc => _imc.status;
  String get nameDisplay => name.trim().isEmpty ? 'Desconhecido' : name;
}
