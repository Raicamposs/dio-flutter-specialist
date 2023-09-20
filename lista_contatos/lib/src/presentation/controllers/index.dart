import 'package:lista_contatos/src/presentation/dtos/user-form.dart';
import 'package:lista_contatos/src/presentation/dtos/user-list.dart';

abstract class IHomeController {
  Stream<Map<String, List<UserList>>> list();
  void onSearch(String value);
  Future<void> reload();
  void dispose();
}

abstract class IFormController {
  Future<void> save(UserForm input);
  Future<void> delete(String id);
}
