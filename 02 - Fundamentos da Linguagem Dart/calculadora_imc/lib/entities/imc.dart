class Imc {
  final _data = <String, Map<String, double>>{
    'Magreza grave': {'start': 0, 'end': 16.0},
    'Magreza moderada': {'start': 16.0, 'end': 17.0},
    'Magreza leve': {'start': 17.0, 'end': 18.5},
    'Saudável': {'start': 18.5, 'end': 25.0},
    'Sobrepeso': {'start': 25.0, 'end': 30.0},
    'Obesidade grau I': {'start': 30.0, 'end': 35.0},
    'Obesidade grau II (severa)': {'start': 35.0, 'end': 40.0},
    'Obesidade grau III (mórbida)': {'start': 40.0, 'end': double.infinity},
  };

  final double height;
  final double weight;

  Imc({required double height, required double weight})
      : height = height.abs(),
        weight = weight.abs(),
        assert(
          height != 0 && weight != 0,
          'Altura($height) e peso($weight) devem ser maiores que 0',
        );

  double get value => weight / (height * height);

  String get status {
    final imc = value;
    final description = _data.entries.firstWhere(
      (entry) => imc >= entry.value['start']! && imc < entry.value['end']!,
    );

    return description.key;
  }
}
