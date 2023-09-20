import 'package:lista_contatos/src/domain/entities/user.dart';
import 'package:lista_contatos/src/domain/services/user.services.dart';
import 'package:uuid/uuid.dart';

class UserServiceImMemory implements UserService {
  UserServiceImMemory._() {
    _users = [
      'Ana',
      'Pedro',
      'João',
      'Maria',
      'José',
      'Paulo',
    ]
        .map((name) => User(
              id: const Uuid().v4(),
              name: name,
              jobTitle: 'Developer',
              company: 'Qualquer empresa',
              notes:
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
              address: 'Rua 1, 123 - Centro - São Paulo - SP',
              photo: '',
              birthday: DateTime.now(),
            ))
        .toList();
  }

  static final _instance = UserServiceImMemory._();

  factory UserServiceImMemory() {
    return _instance;
  }

  late List<User> _users;

  @override
  Future<User> create(User user) {
    _users.add(user);
    return Future.value(user);
  }

  @override
  Future<void> delete(String id) {
    _users.removeWhere((user) => user.id == id);
    return Future.value();
  }

  @override
  Future<bool> exists(String id) {
    final exist = _users.where((user) => user.id == id).isNotEmpty;
    return Future.value(exist);
  }

  @override
  Future<User> find(String id) {
    final user = _users.firstWhere((user) => user.id == id);
    return Future.value(user);
  }

  @override
  Future<List<User>> list() {
    return Future.value(_users);
  }

  @override
  Future<User> update(User user) {
    final index = _users.indexWhere((u) => u.id == user.id);
    _users[index] = user;
    return Future.value(user);
  }
}
