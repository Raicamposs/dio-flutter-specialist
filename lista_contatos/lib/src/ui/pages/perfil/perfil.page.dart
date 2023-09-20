import 'package:flutter/material.dart';
import 'package:lista_contatos/src/domain/entities/user.dart';
import 'package:lista_contatos/src/presentation/dtos/user-form.dart';
import 'package:lista_contatos/src/presentation/dtos/user-list.dart';
import 'package:lista_contatos/src/ui/components/image/image_avatar.dart';
import 'package:lista_contatos/src/ui/routes/app_routes.dart';

import '../../components/visible_when.widget.dart';
import 'components/index.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({Key? key, required this.data}) : super(key: key);
  final UserList data;

  factory PerfilPage.fromArgs(BuildContext context, {Key? key}) {
    return PerfilPage(
      key: key,
      data: ModalRoute.of(context)?.settings.arguments as UserList,
    );
  }

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  User get user => widget.data.user;

  _onEdit() {
    Navigator.pushNamed(
      context,
      AppRoutes.form,
      arguments: UserForm.fromUser(user),
    ).whenComplete(() => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 200,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  FractionallySizedBox(
                    heightFactor: 0.5,
                    alignment: Alignment.topCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColorDark
                          ],
                        ),
                      ),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: 0.5,
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 16,
                        right: 16,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                              child: Text(
                            widget.data.title,
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          )),
                          Visible.whenIsNotMobile(
                            context: context,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                              ),
                              child: SizedBox(
                                height: 40,
                                child: Hero(
                                  tag: user.id,
                                  child: FilledButton.icon(
                                    onPressed: _onEdit,
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      'Editar',
                                      style: textTheme.labelLarge?.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Hero(
                        tag: 'view_${user.id}',
                        child: ImageAvatar(
                          imageUrl: user.photo,
                          semanticLabel: user.name,
                          radius: 45,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            TextItem(
              icon: Icons.business_center_outlined,
              title: user.jobTitle,
            ),
            TextItem(
              icon: Icons.business_outlined,
              title: user.company,
            ),
            TextListItem(
              icon: Icons.mail_outline,
              data: user.emails.map((e) => (e.value, e.label)).toList(),
            ),
            TextListItem(
              icon: Icons.phone_outlined,
              data: user.phones.map((e) => (e.value, e.label)).toList(),
            ),
            TextItem(
              icon: Icons.pin_drop_outlined,
              title: user.address,
            ),
            TextItem.date(
              icon: Icons.cake_outlined,
              date: user.birthday,
            ),
            TextItem(
              icon: Icons.format_align_left_outlined,
              title: user.notes,
            ),
          ],
        ),
      ),
      floatingActionButton: Visible.whenIsMobile(
        context: context,
        child: FloatingActionButton(
          heroTag: user.id,
          onPressed: _onEdit,
          child: const Icon(Icons.edit),
        ),
      ),
    );
  }
}
