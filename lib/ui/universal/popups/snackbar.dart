import "package:flutter/material.dart";

void snackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2, milliseconds: 500),
      content: Text(text),
    ),
  );
}
