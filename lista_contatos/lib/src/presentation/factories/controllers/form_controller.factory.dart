import 'package:lista_contatos/src/domain/use-cases/index.dart';
import 'package:lista_contatos/src/presentation/factories/services/user_services.factory.dart';

import '../../controllers/implementations/index.dart';
import '../../controllers/index.dart';

IFormController makeFormController() {
  final service = makeUserService();
  final ISaveUsersUseCase saveUseCase = SaveUsersUseCase(service);
  final IDeleteUserUseCase deleteUseCase = DeleteUserUseCase(service);
  return FormController(
    saveUseCase: saveUseCase,
    deleteUseCase: deleteUseCase,
  );
}
