import 'dart:collection';

class ImcRange {
  final double start;
  final double end;
  final int color;

  String get range {
    if (start == 0) {
      return '< ${end.toStringAsFixed(1)}';
    }

    if (end > 40) {
      return '≥ ${start.toStringAsFixed(1)}';
    }

    return '${start.toStringAsFixed(1)} - ${(end - 0.1).toStringAsFixed(1)}';
  }

  ImcRange({
    required this.start,
    required this.end,
    required this.color,
  });
}

class Imc {
  final _data = <String, ImcRange>{
    'Magreza grave': ImcRange(
      start: 0,
      end: 16.0,
      color: 0xFFc02e1d,
    ),
    'Magreza moderada': ImcRange(
      start: 16.0,
      end: 17.0,
      color: 0xFFd94e1f,
    ),
    'Magreza leve': ImcRange(
      start: 17.0,
      end: 18.5,
      color: 0xFFf16c20,
    ),
    'Saudável': ImcRange(
      start: 18.5,
      end: 25.0,
      color: 0xFFef8b2c,
    ),
    'Sobrepeso': ImcRange(
      start: 25.0,
      end: 30.0,
      color: 0xFFecaa38,
    ),
    'Obesidade grau I': ImcRange(
      start: 30.0,
      end: 35.0,
      color: 0xFFebc844,
    ),
    'Obesidade grau II (severa)': ImcRange(
      start: 35.0,
      end: 40.0,
      color: 0xFFa2b86c,
    ),
    'Obesidade grau III (mórbida)': ImcRange(
      start: 40.0,
      end: 100,
      color: 0xFF5ca793,
    ),
  };

  final double height;
  final double weight;

  UnmodifiableMapView<String, ImcRange> get data => UnmodifiableMapView(_data);

  Imc({required double height, required double weight})
      : height = height.abs(),
        weight = weight.abs(),
        assert(
          height != 0 && weight != 0,
          'Altura($height) e peso($weight) devem ser maiores que 0',
        );

  double get value => weight / (height * height);

  String get status {
    final description = _data.entries.firstWhere(
      (entry) => value >= entry.value.start && value < entry.value.end,
    );

    return description.key;
  }

  String get range {
    final description = _data.entries.firstWhere(
      (entry) => value >= entry.value.start && value < entry.value.end,
    );

    return description.value.range;
  }

  String get valueFormatted => '${value.toStringAsFixed(1)}kg/m²';
  String get weightFormatted => '${weight.toStringAsFixed(1)}kg';
  String get heightFormatted => '${height.toStringAsFixed(1)}m';

  @override
  String toString() {
    return '${value.toStringAsFixed(1)} - $status';
  }
}
