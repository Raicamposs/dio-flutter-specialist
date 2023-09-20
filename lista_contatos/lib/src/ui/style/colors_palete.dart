import 'dart:math';
import 'dart:ui';

const List<Color> _paleteConstrasting = [
  Color.fromARGB(255, 72, 72, 106), //Roxo Escuro 0
  Color.fromARGB(255, 94, 93, 137), //Roxo Claro 1
  Color.fromARGB(255, 214, 101, 95), //Varmelho Escuro 2
  Color.fromARGB(255, 233, 130, 125), //Varmelho Claro 3
  Color.fromARGB(255, 250, 217, 138), //Amarelo Claro 4
  Color.fromARGB(255, 245, 197, 89), //Amarelo Escuro 5
  Color.fromARGB(255, 75, 146, 128), //Verde Escuro 6
  Color.fromARGB(255, 94, 176, 161), //Verde Claro 7
  Color.fromARGB(255, 86, 134, 182), //Azul Claro 8
  Color.fromARGB(255, 61, 106, 145), //Azul Escuro 9
  Color.fromARGB(255, 205, 129, 69), //Laranja Escuro 10
  Color.fromARGB(255, 237, 149, 77), //Laranja Claro 11
];

const List<Color> _paleteColorsCharts = [
  Color(0xFF1395ba),
  Color(0xFF117899),
  Color(0xFF0f5b78),
  Color(0xFF0d3c55),
  Color(0xFFc02e1d),
  Color(0xFFd94e1f),
  Color(0xFFf16c20),
  Color(0xFFef8b2c),
  Color(0xFFecaa38),
  Color(0xFFebc844),
  Color(0xFFa2b86c),
  Color(0xFF5ca793)
];

class ColorPalete {
  static final Random _random = Random(0);

  static Color radomColor() {
    return _paleteColorsCharts[_random.nextInt(_paleteColorsCharts.length)];
  }

  static List<Color> getStandardPalette(int length) {
    switch (length) {
      case 1:
        return [_paleteColorsCharts[0]];
      case 2:
        return [_paleteColorsCharts[0], _paleteColorsCharts[6]];
      case 3:
        return [
          _paleteColorsCharts[0],
          _paleteColorsCharts[3],
          _paleteColorsCharts[6]
        ];
      case 4:
        return [
          _paleteColorsCharts[0],
          _paleteColorsCharts[3],
          _paleteColorsCharts[6],
          _paleteColorsCharts[9]
        ];
      case 5:
        return [
          _paleteColorsCharts[0],
          _paleteColorsCharts[3],
          _paleteColorsCharts[4],
          _paleteColorsCharts[6],
          _paleteColorsCharts[9],
        ];
      case 6:
        return [
          _paleteColorsCharts[0],
          _paleteColorsCharts[3],
          _paleteColorsCharts[4],
          _paleteColorsCharts[6],
          _paleteColorsCharts[9],
          _paleteColorsCharts[10]
        ];
      case 7:
        return [
          _paleteColorsCharts[0],
          _paleteColorsCharts[2],
          _paleteColorsCharts[3],
          _paleteColorsCharts[4],
          _paleteColorsCharts[6],
          _paleteColorsCharts[9],
          _paleteColorsCharts[10]
        ];
      default:
        return _paleteColorsCharts;
      // List<Color> color = [];
      // color.addAll(_paleteColorsCharts);
      // color.insert(4, Color(0xFF7C13BA));
      // color.insert(5, Color(0xFFA113BA));
      // return color;
    }
  }

  static List<Color> getPaleteConstrasting(int length) {
    switch (length) {
      case 1:
        return [_paleteConstrasting[0]];
      case 2:
        return [_paleteConstrasting[0], _paleteConstrasting[2]];
      case 3:
        return [
          _paleteConstrasting[0],
          _paleteConstrasting[2],
          _paleteConstrasting[5]
        ];
      case 4:
        return [
          _paleteConstrasting[0],
          _paleteConstrasting[2],
          _paleteConstrasting[5],
          _paleteConstrasting[7]
        ];
      case 5:
        return [
          _paleteConstrasting[0],
          _paleteConstrasting[1],
          _paleteConstrasting[2],
          _paleteConstrasting[5],
          _paleteConstrasting[7]
        ];
      case 6:
        return [
          _paleteConstrasting[0],
          _paleteConstrasting[1],
          _paleteConstrasting[2],
          _paleteConstrasting[3],
          _paleteConstrasting[5],
          _paleteConstrasting[7]
        ];
      case 7:
        return [
          _paleteConstrasting[0],
          _paleteConstrasting[1],
          _paleteConstrasting[2],
          _paleteConstrasting[3],
          _paleteConstrasting[4],
          _paleteConstrasting[5],
          _paleteConstrasting[7]
        ];
      default:
        return _paleteConstrasting;
    }
  }
}
