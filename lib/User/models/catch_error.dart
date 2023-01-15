import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

mixin CatchError {
  bool catchs(void Function() a,
      {required BuildContext context,
      required String onError,
      required String onSuccess}) {
    try {
      a;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(onSuccess),
      ));
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(onError),
        action: SnackBarAction(
          label: 'Copiar',
          onPressed: () {
            Clipboard.setData(ClipboardData(text: e.toString()));
          },
        ),
      ));
    }
    return false;
  }
}
