// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app_calculadora_imc/src/domain/entities/imc.dart';
import 'package:intl/intl.dart';

class History {
  final String id;
  final double height;
  final double weight;
  final double imc;
  final DateTime date;

  History({
    required this.id,
    required this.height,
    required this.weight,
    required this.imc,
    required this.date,
  });

  String get imcFormatted => '${imc.toStringAsFixed(1)}kg/m²';
  String get dateFormatted => DateFormat.yMd().format(date);
  String get weightFormatted => '${weight.toStringAsFixed(1)}kg';
  String get heightFormatted => '${height.toStringAsFixed(1)}m';

  Imc get imcData => Imc(
        height: height,
        weight: weight,
      );

  History copyWith({
    String? id,
    double? height,
    double? weight,
    double? imc,
    DateTime? date,
  }) {
    return History(
      id: id ?? this.id,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      imc: imc ?? this.imc,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'height': height,
      'weight': weight,
      'imc': imc,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory History.fromMap(Map<String, dynamic> map) {
    return History(
      id: map['id'] as String,
      height: map['height'] as double,
      weight: map['weight'] as double,
      imc: map['imc'] as double,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory History.fromJson(String source) =>
      History.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'History(id: $id, height: $height, weight: $weight, imc: $imc, date: $date)';
  }

  @override
  bool operator ==(covariant History other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.height == height &&
        other.weight == weight &&
        other.imc == imc &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        height.hashCode ^
        weight.hashCode ^
        imc.hashCode ^
        date.hashCode;
  }
}
