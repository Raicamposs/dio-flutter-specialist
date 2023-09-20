import 'package:lista_contatos/src/domain/services/user.services.dart';

abstract class IDeleteUserUseCase {
  Future<void> call(String id);
}

class DeleteUserUseCase implements IDeleteUserUseCase {
  final UserService _service;

  DeleteUserUseCase(this._service);

  @override
  Future<void> call(String id) async {
    await _service.delete(id);
  }
}
