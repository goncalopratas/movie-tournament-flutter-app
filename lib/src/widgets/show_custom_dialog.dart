import 'package:flutter/material.dart';

void showCustomDialog(
  BuildContext context, {
  required IconData icon,
  String? message,
  required VoidCallback onTap,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              size: 50,
            ),
            SizedBox(height: 16),
            Text(
              message ?? "",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: onTap,
              child: Text('Fechar'),
            ),
          ],
        ),
      );
    },
  );
}
