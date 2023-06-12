import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

void errorDialog(BuildContext context, String error) {
  if (kDebugMode) {
    print("Error Messages:");
    print(error.toString());
  }
  showDialog(
    context: context,
    builder: (context) {
      return SelectionArea(
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          contentPadding: const EdgeInsets.all(16.0),
          title: const Text(
            "Error:",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(error.toString()),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            )
          ],
        ),
      );
    },
  );
}
