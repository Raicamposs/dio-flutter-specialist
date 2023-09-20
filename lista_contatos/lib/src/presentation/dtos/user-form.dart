// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:lista_contatos/src/domain/entities/email.dart';
import 'package:lista_contatos/src/domain/entities/phone.dart';
import 'package:lista_contatos/src/domain/entities/user.dart';
import 'package:lista_contatos/src/ui/components/forms/email_list_form_field.widget.dart';
import 'package:lista_contatos/src/ui/components/forms/phone_form_field.widget.dart';
import 'package:uuid/uuid.dart';

class UserForm {
  final String? id;
  final String name;
  final String? jobTitle;
  final String? company;
  final String? notes;
  final List<EmailData> emails;
  final List<PhoneData> phones;
  final String? address;
  final String? photo;
  final DateTime? birthday;

  UserForm({
    this.id,
    required this.name,
    this.jobTitle,
    this.company,
    this.notes,
    this.emails = const [],
    this.phones = const [],
    this.address,
    this.photo,
    this.birthday,
  });

  User toEntity() {
    return User(
      id: id ?? const Uuid().v4(),
      name: name,
      jobTitle: jobTitle,
      company: company,
      notes: notes,
      emails: emails.map((e) => Email(e.email, e.label)).toList(),
      phones: phones.map((e) => Phone(e.number, e.label)).toList(),
      address: address,
      photo: photo,
      birthday: birthday,
    );
  }

  factory UserForm.fromUser(User user) {
    return UserForm(
      id: user.id,
      name: user.name,
      jobTitle: user.jobTitle,
      company: user.company,
      notes: user.notes,
      emails: user.emails
          .map((e) => EmailData(email: e.value, label: e.label))
          .toList(),
      phones: user.phones
          .map((e) => PhoneData(number: e.value, label: e.label))
          .toList(),
      address: user.address,
      photo: user.photo,
      birthday: user.birthday,
    );
  }

  UserForm copyWith({
    String? id,
    String? name,
    String? jobTitle,
    String? company,
    String? notes,
    List<EmailData>? emails,
    List<PhoneData>? phones,
    String? address,
    String? photo,
    DateTime? birthday,
  }) {
    return UserForm(
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'jobTitle': jobTitle,
      'company': company,
      'notes': notes,
      'emails': emails,
      'phones': phones,
      'address': address,
      'photo': photo,
      'birthday': birthday,
    };
  }

  factory UserForm.fromMap(Map<String, dynamic> map) {
    return UserForm(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      jobTitle: map['jobTitle'] != null ? map['jobTitle'] as String : null,
      company: map['company'] != null ? map['company'] as String : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
      emails: map['emails'],
      phones: map['phones'],
      address: map['address'] != null ? map['address'] as String : null,
      photo: map['photo'] != null ? map['photo'] as String : null,
      birthday: map['birthday'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserForm.fromJson(String source) =>
      UserForm.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserForm(id: $id, name: $name, jobTitle: $jobTitle, company: $company, notes: $notes, emails: [${emails.map((e) => e.toString()).join(',')}], phones: [${phones.map((e) => e.toString()).join(',')}], address: $address, photo: $photo, birthday: $birthday)';
  }

  @override
  bool operator ==(covariant UserForm other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.jobTitle == jobTitle &&
        other.company == company &&
        other.notes == notes &&
        listEquals(other.emails, emails) &&
        listEquals(other.phones, phones) &&
        other.address == address &&
        other.photo == photo &&
        other.birthday == birthday;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        jobTitle.hashCode ^
        company.hashCode ^
        notes.hashCode ^
        emails.hashCode ^
        phones.hashCode ^
        address.hashCode ^
        photo.hashCode ^
        birthday.hashCode;
  }
}
