import 'package:flutter/material.dart';
import 'package:lista_contatos/src/ui/components/visible_when.widget.dart';

const _borderSide = BorderSide(
  color: Color.fromRGBO(230, 235, 242, 1),
  width: 1,
);

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    required this.count,
    this.onTap,
    this.onSearch,
  }) : super(key: key);

  final int count;
  final void Function()? onTap;
  final void Function(String?)? onSearch;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Contatos',
            style: textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$count contatos',
            style: textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: onSearch,
                  decoration: const InputDecoration(
                    hintText: 'Pesquisar contatos',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Visible.whenIsNotMobile(
                context: context,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: SizedBox(
                    height: 50,
                    child: FilledButton.icon(
                      onPressed: onTap,
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Adicionar',
                        style: textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
