import 'package:lista_contatos/src/domain/entities/user.dart';

abstract class UserService {
  Future<User> create(User user);
  Future<User> find(String id);
  Future<User> update(User user);
  Future<void> delete(String id);
  Future<bool> exists(String id);
  Future<List<User>> list();
}
