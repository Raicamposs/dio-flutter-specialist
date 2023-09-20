import 'package:lista_contatos/src/domain/entities/user.dart';
import 'package:lista_contatos/src/domain/services/user.services.dart';

abstract class ISaveUsersUseCase {
  Future<void> call(User user);
}

class SaveUsersUseCase implements ISaveUsersUseCase {
  final UserService _service;

  SaveUsersUseCase(this._service);

  @override
  Future<void> call(User user) async {
    final alreadyExists = await _service.exists(user.id);

    if (alreadyExists) {
      await _service.update(user);
    } else {
      await _service.create(user);
    }
  }
}
