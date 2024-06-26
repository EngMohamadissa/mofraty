import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.onCancel,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
      content: Text(
        content,
        style: TextStyle(
          color: Theme.of(context).textTheme.titleMedium?.color,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'إلغاء',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          onPressed: () {
            onCancel();
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text(
            'تأكيد',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            // تنفيذ الوظيفة عند التأكيد
            onConfirm();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
