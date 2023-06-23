import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:textatize_admin/ui/universal/popups/snackbar.dart";

void errorDialog(BuildContext context, String error) {
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
            child: Text(error),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () async {
                    await Clipboard.setData(
                      ClipboardData(text: error),
                    );
                    snackbar(context, "Error copied to clipboard!");
                  },
                  child: const Text("Copy Error"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
