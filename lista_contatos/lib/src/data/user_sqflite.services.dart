import 'dart:convert';

import 'package:lista_contatos/src/domain/entities/email.dart';
import 'package:lista_contatos/src/domain/entities/phone.dart';
import 'package:lista_contatos/src/domain/entities/user.dart';
import 'package:lista_contatos/src/domain/services/user.services.dart';
import 'package:sqflite/sqflite.dart';

class UserSqfliteService implements UserService {
  Database? _database;

  Future<Database> _initialize() async {
    if (_database != null) {
      return _database!;
    }

    final path = await getDatabasesPath();
    _database = await openDatabase(
      [path, 'meus_contatos.db'].join('/'),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE users(
            id TEXT PRIMARY KEY,
            name TEXT,
            jobTitle TEXT,
            company TEXT,
            notes TEXT,
            address TEXT,
            photo TEXT,
            birthday TEXT,
            emails TEXT,
            phones TEXT
          )
          ''',
        );
      },
      version: 1,
    );
    return _database!;
  }

  @override
  Future<User> create(User user) async {
    final db = await _initialize();
    await db.insert(
      'users',
      _userToMap(user),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return user;
  }

  @override
  Future<void> delete(String id) async {
    final db = await _initialize();
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<bool> exists(String id) async {
    final db = await _initialize();
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );

    return maps.isNotEmpty;
  }

  @override
  Future<User> find(String id) async {
    final db = await _initialize();
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    return _mapToUser(maps.first);
  }

  @override
  Future<List<User>> list() async {
    final db = await _initialize();
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return _mapToUser(maps[i]);
    });
  }

  @override
  Future<User> update(User user) async {
    final db = await _initialize();
    await db.update(
      'users',
      _userToMap(user),
      where: 'id = ?',
      whereArgs: [user.id],
    );
    return user;
  }

  _mapToUser(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      jobTitle: map['jobTitle'],
      company: map['company'],
      notes: map['notes'],
      address: map['address'],
      photo: map['photo'],
      birthday:
          map['birthday'] == null ? null : DateTime.parse(map['birthday']),
      emails: List<Map<String, dynamic>>.from(jsonDecode(map['emails']))
          .map((e) => Email(e['value'], e['label']))
          .toList(),
      phones: List<Map<String, dynamic>>.from(jsonDecode(map['phones']))
          .map((e) => Phone(e['value'], e['label']))
          .toList(),
    );
  }

  _userToMap(User user) {
    final emailMap = user.emails
        .map((e) => ({
              'label': e.label,
              'value': e.value,
            }))
        .toList();

    final phonesMap = user.phones
        .map((e) => ({
              'label': e.label,
              'value': e.value,
            }))
        .toList();

    return {
      'id': user.id,
      'name': user.name,
      'jobTitle': user.jobTitle,
      'company': user.company,
      'notes': user.notes,
      'address': user.address,
      'photo': user.photo,
      'birthday': user.birthday?.toIso8601String(),
      'emails': jsonEncode(emailMap),
      'phones': jsonEncode(phonesMap)
    };
  }
}
