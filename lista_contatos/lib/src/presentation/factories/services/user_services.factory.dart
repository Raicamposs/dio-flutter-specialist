import 'package:lista_contatos/src/data/user_sqflite.services.dart';
import 'package:lista_contatos/src/domain/services/user.services.dart';

UserService makeUserService() {
  return UserSqfliteService();
}
