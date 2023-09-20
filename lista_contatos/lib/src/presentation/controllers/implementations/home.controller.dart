import 'package:lista_contatos/src/domain/use-cases/index.dart';
import 'package:lista_contatos/src/presentation/controllers/index.dart';
import 'package:lista_contatos/src/presentation/dtos/user-list.dart';
import 'package:rxdart/rxdart.dart';

class HomeController implements IHomeController {
  final IListUsersUseCase _useCase;

  HomeController({required IListUsersUseCase useCase}) : _useCase = useCase;

  final _subject = BehaviorSubject<Map<String, List<UserList>>>();
  final _search = BehaviorSubject<String>.seeded('');

  @override
  Stream<Map<String, List<UserList>>> list() {
    return CombineLatestStream([_subject, _search], (event) {
      final data = event[0] as Map<String, List<UserList>>;
      final search = event[1] as String;

      if (search.isEmpty) {
        return data;
      }

      final output = <String, List<UserList>>{};
      data.forEach((key, value) {
        final filtered = value.where((element) {
          return element.title.toLowerCase().contains(search.toLowerCase());
        }).toList();
        if (filtered.isNotEmpty) {
          output[key] = filtered;
        }
      });

      return output;
    });
  }

  @override
  void onSearch(String value) {
    _search.add(value);
  }

  @override
  Future<void> reload() async {
    final output = <String, List<UserList>>{};
    final users = await _useCase.call();
    final usersList = users.map((e) => UserList(e)).toList();
    usersList.sort((a, b) => a.initial.compareTo(b.initial));

    for (var user in usersList) {
      output.update(
        user.initial,
        (data) => [...data, user]..sort(
            (a, b) => a.title.compareTo(b.title),
          ),
        ifAbsent: () => [user],
      );
    }

    _subject.add(output);
  }

  @override
  void dispose() {
    _subject.close();
    _search.close();
  }
}
