import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:textatize_admin/ui/universal/popups/snackbar.dart";

import "../../../models/user_model.dart";

class UserInfoPopup extends StatelessWidget {
  final User user;

  const UserInfoPopup(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      contentPadding: const EdgeInsets.all(16.0),
      content: SizedBox(
        width: 350,
        height: 400,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "User Info",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.grey,
              height: .5,
            ),
            Expanded(
              child: ListView(
                children: [
                  infoTile("Unique Id", user.uniqueId, context),
                  infoTile("Username", user.username, context),
                  infoTile("Email", user.email, context),
                  infoTile("First Name", user.firstName, context),
                  infoTile("Last Name", user.lastName, context),
                  infoTile("Phone", user.phone, context),
                  infoTile("Points", user.points.toString(), context),
                  infoTile("Created", user.createdFormatted, context),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.grey,
              height: .5,
            ),
            Row(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Done"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget infoTile(String title, String content, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          color: Colors.grey,
          height: .5,
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "$title: ",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(
                  content,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          trailing: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () async {
                await Clipboard.setData(
                  ClipboardData(text: content),
                );
                snackbar(context, "$title copied to clipboard!");
              },
            ),
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.grey,
          height: .5,
        ),
      ],
    );
  }
}
