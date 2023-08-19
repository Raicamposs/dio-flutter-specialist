import 'package:calculadora_imc/entities/person.dart';
import 'package:test/test.dart';

void main() {
  test('Deve resultar Magreza grave', () {
    final person = Person(name: 'any', height: 1, weight: 14);
    expect(person.imc, 14);
    expect(person.status, 'Magreza grave');
  });
  test('Deve resultar Magreza moderada', () {
    final person = Person(name: 'any', height: 1, weight: 16.5);
    expect(person.imc, 16.5);
    expect(person.status, 'Magreza moderada');
  });
  test('Deve resultar Magreza leve', () {
    final person = Person(name: 'any', height: 1, weight: 17);
    expect(person.imc, 17);
    expect(person.status, 'Magreza leve');
  });
  test('Deve resultar Saudável', () {
    final person = Person(name: 'any', height: 1, weight: 20);
    expect(person.imc, 20);
    expect(person.status, 'Saudável');
  });
  test('Deve resultar Sobrepeso', () {
    final person = Person(name: 'any', height: 1, weight: 26);
    expect(person.imc, 26);
    expect(person.status, 'Sobrepeso');
  });
  test('Deve resultar Obesidade grau I', () {
    final person = Person(name: 'any', height: 1, weight: 31);
    expect(person.imc, 31);
    expect(person.status, 'Obesidade grau I');
  });
  test('Deve resultar Obesidade grau II (severa)', () {
    final person = Person(name: 'any', height: 1, weight: 37);
    expect(person.imc, 37);
    expect(person.status, 'Obesidade grau II (severa)');
  });
  test('Deve resultar Obesidade grau III (mórbida)', () {
    final person = Person(name: 'any', height: 1, weight: 50);
    expect(person.imc, 50);
    expect(person.status, 'Obesidade grau III (mórbida)');
  });
}
