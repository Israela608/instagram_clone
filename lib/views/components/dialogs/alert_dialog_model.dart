import 'package:flutter/material.dart';

@immutable
class AlertDialogModel<T> {
  const AlertDialogModel({
    required this.title,
    required this.message,
    required this.buttons,
  });

  final String title;
  final String message;
  final Map<String, T> buttons;
}

// This is just an extension of the above class.
// You can move the present() function from this extension to the class above and it will still be the same thing
extension Present<T> on AlertDialogModel<T> {
  Future<T?> present(BuildContext context) {
    return showDialog<T>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: buttons.entries.map((entry) {
              return TextButton(
                child: Text(
                  entry.key,
                ),
                onPressed: () {
                  Navigator.of(context).pop(entry.value);
                },
              );
            }).toList(),
          );
        });
  }
}
