import 'package:lista_contatos/src/domain/use-cases/index.dart';
import 'package:lista_contatos/src/presentation/controllers/implementations/home.controller.dart';
import 'package:lista_contatos/src/presentation/controllers/index.dart';
import 'package:lista_contatos/src/presentation/factories/services/user_services.factory.dart';

IHomeController makeHomeController() {
  final service = makeUserService();
  final IListUsersUseCase listUsersUseCase = ListUsersUseCase(service);
  return HomeController(useCase: listUsersUseCase);
}
