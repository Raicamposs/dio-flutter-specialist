import 'package:calculadora_imc/entities/person.dart';
import 'package:calculadora_imc/service/console.util.dart';

void calculate() {
  final String name =
      ConsoleUtils.instance().white('Qual é o seu nome?').read().answer();

  final double? height = ConsoleUtils.instance()
      .white('Qual é o sua altura?')
      .read()
      .doubleAnswer();

  if (height == null || height == 0) {
    print('Altura inválida');
    return;
  }

  final double? weight =
      ConsoleUtils.instance().white('Qual é o seu peso?').read().doubleAnswer();

  if (weight == null || weight == 0) {
    print('Peso inválidos');
    return;
  }

  try {
    final person = Person(name: name, height: height, weight: weight);
    print('Olá ${person.name}, seu IMC é ${person.imc}');
    print('Você está ${person.status}');
  } on AssertionError catch (e) {
    print(e.message);
  } catch (e) {
    print('Ocorreu um erro inesperado. Tente novamente.');
  }
}
