import 'package:flutter/material.dart';
import 'package:lista_contatos/src/presentation/controllers/index.dart';
import 'package:lista_contatos/src/presentation/dtos/user-list.dart';
import 'package:lista_contatos/src/presentation/factories/controllers/home_controller.factory.dart';
import 'package:lista_contatos/src/ui/components/visible_when.widget.dart';
import 'package:lista_contatos/src/ui/pages/home/components/index.dart';
import 'package:lista_contatos/src/ui/routes/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.controller}) : super(key: key);
  final IHomeController controller;

  factory HomePage.fromArgs(BuildContext context, {Key? key}) {
    return HomePage(
      key: key,
      controller: makeHomeController(),
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> _makeListData(Map<String, List<UserList>>? data) {
    if (data == null) {
      return const [];
    }

    final List<Widget> items = <Widget>[];
    data.forEach((key, value) {
      items.add(GroupWidget(
        title: key,
      ));
      items.addAll(
        value.map(
          (contact) => ListItemWidget(
            data: contact,
            onTap: (output) {
              Navigator.pushNamed(context, AppRoutes.perfil, arguments: output)
                  .whenComplete(() => widget.controller.reload());
            },
          ),
        ),
      );
    });

    return items;
  }

  @override
  void initState() {
    widget.controller
        .reload()
        .whenComplete(() => widget.controller.onSearch(''));

    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            HeaderWidget(
              count: 10,
              onTap: _addNew,
              onSearch: (value) => widget.controller.onSearch(value ?? ''),
            ),
            StreamBuilder(
              stream: widget.controller.list(),
              builder: (_, snapshot) {
                if (snapshot.hasData == false) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final items = _makeListData(snapshot.data);

                return Expanded(
                  child: ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (_, index) => items[index],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Visible.whenIsMobile(
        context: context,
        child: FloatingActionButton(
          heroTag: 'new',
          onPressed: _addNew,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _addNew() {
    Navigator.pushNamed(context, AppRoutes.form)
        .whenComplete(() => widget.controller.reload());
  }
}
