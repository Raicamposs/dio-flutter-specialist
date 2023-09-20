import 'package:lista_contatos/src/domain/entities/user.dart';

class UserList {
  final User user;

  UserList(this.user);

  String get id => user.id;
  String get title => user.name;
  String get subtitle => user.phones.firstOrNull?.value ?? '';
  String get initial => user.name[0].toUpperCase();
  String get photo => user.photo ?? '';
}
