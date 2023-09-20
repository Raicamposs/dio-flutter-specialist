import 'package:lista_contatos/src/domain/entities/user.dart';
import 'package:lista_contatos/src/domain/services/user.services.dart';

abstract class IFindUserUseCase {
  Future<User> call(String id);
}

class FindUserUseCase implements IFindUserUseCase {
  final UserService _service;

  FindUserUseCase(this._service);

  @override
  Future<User> call(String id) async {
    return await _service.find(id);
  }
}
