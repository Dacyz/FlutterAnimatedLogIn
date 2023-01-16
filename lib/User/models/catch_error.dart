import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

mixin CatchError {
  ///
  /// Clase por aburrimiento :v
  /// 

  Future<bool> catchs(Future<bool> Function() a,
      {required BuildContext context,
      required String onError,
      required String onSuccess}) async {
    try {
      if (await a.call()) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(onSuccess),
        ));
        return true;
      }
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
