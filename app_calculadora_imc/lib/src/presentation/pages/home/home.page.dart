import 'package:app_calculadora_imc/src/domain/entities/history.dart';
import 'package:app_calculadora_imc/src/main/factories/controllers/home_controller.factory.dart';
import 'package:app_calculadora_imc/src/presentation/common/animations/animate_specials.dart';
import 'package:app_calculadora_imc/src/presentation/components/shimmer_list.dart';
import 'package:app_calculadora_imc/src/presentation/pages/home/home.controller.dart';
import 'package:app_calculadora_imc/src/presentation/routes/app_routes.dart';
import 'package:app_calculadora_imc/src/presentation/style/app.colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.controller}) : super(key: key);
  final HomeController controller;

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
  Future<void> _addNew() async {
    await Navigator.of(context)
        .pushNamed(
          AppRoutes.imcForm,
          arguments: widget.controller.lastHistory,
        )
        .whenComplete(() => widget.controller.reload());
  }

  Future<void> _listAll() async {
    await Navigator.of(context).pushNamed(AppRoutes.history);
  }

  @override
  void initState() {
    widget.controller.reload();
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final subtitleStyle = textTheme.titleLarge?.copyWith(
      color: AppColors.primary[800],
    );

    final titleStyle = textTheme.displayMedium?.copyWith(
      color: AppColors.primary[800],
    );

    return Scaffold(
      backgroundColor: AppColors.gray[200],
      body: Column(
        children: [
          SizedBox(
            height: 250,
            child: StreamBuilder<History?>(
              stream: widget.controller.lastHistoryStream,
              builder: (_, AsyncSnapshot<History?> snapshot) {
                final imc = snapshot.data?.imcData;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    JelloIn(
                      animate: true,
                      child: Text(
                        'Meu IMC',
                        style: titleStyle,
                      ),
                    ),
                    if (imc != null)
                      JelloIn(
                        animate: true,
                        child: Text(
                          imc.status,
                          style: subtitleStyle,
                        ),
                      ),
                    if (imc != null)
                      JelloIn(
                        animate: true,
                        child: Text(
                          imc.valueFormatted,
                          style: subtitleStyle,
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.gray[100]!,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Meu histórico',
                      ),
                      Hero(
                        tag: 'history',
                        child: TextButton(
                          onPressed: _listAll,
                          child: const Text(
                            'Ver todos',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<History>>(
                      stream: widget.controller.stream,
                      builder: (_, snapshot) {
                        if (!snapshot.hasData) {
                          return const ShimmerList(itemCount: 5);
                        }

                        return ListView.builder(
                          padding: const EdgeInsets.only(bottom: 24),
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (_, index) {
                            final history = snapshot.data![index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              color: AppColors.gray[200],
                              elevation: 0,
                              child: ListTile(
                                title: Text(history.dateFormatted),
                                subtitle: Text(
                                  '${history.imcFormatted} - ${history.imcData.status}',
                                ),
                              ),
                            );
                          },
                        );
                      }),
                ),
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'image',
        onPressed: _addNew,
        child: const Icon(Icons.add),
      ),
    );
  }
}
