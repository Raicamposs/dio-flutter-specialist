// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lista_contatos/src/domain/entities/user.dart';
import 'package:lista_contatos/src/presentation/dtos/user-form.dart';

import '../../../domain/use-cases/index.dart';
import '../index.dart';

class FormController implements IFormController {
  final ISaveUsersUseCase _saveUseCase;
  final IDeleteUserUseCase _deleteUseCase;

  FormController({
    required IDeleteUserUseCase deleteUseCase,
    required ISaveUsersUseCase saveUseCase,
  })  : _saveUseCase = saveUseCase,
        _deleteUseCase = deleteUseCase;

  @override
  Future<void> save(UserForm input) async {
    User user = input.toEntity();
    await _saveUseCase.call(user);
  }

  @override
  Future<void> delete(String id) async {
    await _deleteUseCase.call(id);
  }
}
