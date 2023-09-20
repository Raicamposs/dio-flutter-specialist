// ignore_for_file: public_member_api_docs, sort_constructors_first
import './email.dart';
import './phone.dart';

class User {
  final String id;
  final String name;
  final String? jobTitle;
  final String? company;
  final String? notes;
  final List<Email> emails;
  final List<Phone> phones;
  final String? address;
  final String? photo;
  final DateTime? birthday;

  User({
    required this.id,
    required this.name,
    required this.jobTitle,
    required this.company,
    required this.notes,
    this.emails = const [],
    this.phones = const [],
    required this.address,
    required this.photo,
    required this.birthday,
  });

  User copyWith({
    String? id,
    String? name,
    String? jobTitle,
    String? company,
    String? notes,
    List<Email>? emails,
    List<Phone>? phones,
    String? address,
    String? photo,
    DateTime? birthday,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      jobTitle: jobTitle ?? this.jobTitle,
      company: company ?? this.company,
      notes: notes ?? this.notes,
      emails: emails ?? this.emails,
      phones: phones ?? this.phones,
      address: address ?? this.address,
      photo: photo ?? this.photo,
      birthday: birthday ?? this.birthday,
    );
  }
}
