import 'package:lista_contatos/src/domain/entities/user.dart';
import 'package:lista_contatos/src/domain/services/user.services.dart';

abstract class IListUsersUseCase {
  Future<List<User>> call();
}

class ListUsersUseCase implements IListUsersUseCase {
  final UserService _service;

  ListUsersUseCase(this._service);

  @override
  Future<List<User>> call() async {
    return await _service.list();
  }
}
