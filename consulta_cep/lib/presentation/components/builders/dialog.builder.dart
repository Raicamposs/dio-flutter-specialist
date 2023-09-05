import 'package:flutter/material.dart';

class DialogBuilder {
  static Future<bool> show(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deseja excluir o endereço?'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Esta ação não poderá ser desfeita.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Sim'),
              onPressed: () {
                Navigator.of(context).pop<bool>(true);
              },
            ),
            TextButton(
              child: const Text('Não'),
              onPressed: () {
                Navigator.of(context).pop<bool>(false);
              },
            ),
          ],
        );
      },
    ).then((value) => value ?? false);
  }
}
