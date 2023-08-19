import 'package:calculadora_imc/entities/imc.dart';
import 'package:test/test.dart';

void main() {
  test('Deve ignorar números negativos', () {
    final imc = Imc(height: -1, weight: -14);
    expect(imc.value, 14);
    expect(imc.status, 'Magreza grave');
  });

  test('Deve retornar erro para altura igual a 0', () {
    expect(() => Imc(height: 0, weight: 50),
        throwsA(TypeMatcher<AssertionError>()));
  });

  test('Deve retornar erro para peso igual a 0', () {
    expect(() => Imc(height: 1.8, weight: 0),
        throwsA(TypeMatcher<AssertionError>()));
  });

  test('Deve retornar erro para altura menor ou igual a 0', () {
    final imc = Imc(height: -1, weight: -14);
    expect(imc.value, 14);
    expect(imc.status, 'Magreza grave');
  });

  test('Deve resultar Magreza grave', () {
    final imc = Imc(height: 1, weight: 14);
    expect(imc.value, 14);
    expect(imc.status, 'Magreza grave');
  });
  test('Deve resultar Magreza moderada', () {
    final imc = Imc(height: 1, weight: 16.5);
    expect(imc.value, 16.5);
    expect(imc.status, 'Magreza moderada');
  });
  test('Deve resultar Magreza leve', () {
    final imc = Imc(height: 1, weight: 17);
    expect(imc.value, 17);
    expect(imc.status, 'Magreza leve');
  });
  test('Deve resultar Saudável', () {
    final imc = Imc(height: 1, weight: 20);
    expect(imc.value, 20);
    expect(imc.status, 'Saudável');
  });
  test('Deve resultar Sobrepeso', () {
    final imc = Imc(height: 1, weight: 26);
    expect(imc.value, 26);
    expect(imc.status, 'Sobrepeso');
  });
  test('Deve resultar Obesidade grau I', () {
    final imc = Imc(height: 1, weight: 31);
    expect(imc.value, 31);
    expect(imc.status, 'Obesidade grau I');
  });
  test('Deve resultar Obesidade grau II (severa)', () {
    final imc = Imc(height: 1, weight: 37);
    expect(imc.value, 37);
    expect(imc.status, 'Obesidade grau II (severa)');
  });
  test('Deve resultar Obesidade grau III (mórbida)', () {
    final imc = Imc(height: 1, weight: 50);
    expect(imc.value, 50);
    expect(imc.status, 'Obesidade grau III (mórbida)');
  });
}
