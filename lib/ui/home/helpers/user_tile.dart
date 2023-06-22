import "package:flutter/material.dart";
import "package:textatize_admin/ui/home/helpers/user_info_popup.dart";
import "package:textatize_admin/ui/universal/popups/snackbar.dart";

import "../../../models/user_model.dart";

class UserTile extends StatefulWidget {
  final User user;

  const UserTile(this.user, {super.key});

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  late User user;
  bool switchLoading = false;

  @override
  void initState() {
    user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          color: Colors.grey,
          height: 0.5,
        ),
        ListTile(
          leading: const Icon(Icons.account_circle),
          title: Text(user.email),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  tooltip: "User Info",
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) => UserInfoPopup(user),
                    );
                  },
                  icon: const Icon(Icons.info),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  tooltip: "Edit Subscription",
                  onPressed: () async {},
                  icon: const Icon(Icons.auto_awesome),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  tooltip: "View Statistics",
                  onPressed: () async {},
                  icon: const Icon(Icons.bar_chart),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  tooltip: "Download Phone Numbers",
                  onPressed: () async {},
                  icon: const Icon(Icons.phone),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  onPressed: () async {
                    if (!switchLoading) {
                      setState(() {
                        switchLoading = true;
                      });
                      // TODO: Reimplement
                      await Future.delayed(
                        const Duration(seconds: 1, milliseconds: 500),
                      );
                      // await TextatizeApi()
                      //     .toggleUser(user.uniqueId, user.enabled);
                      setState(() {
                        user.enabled = !user.enabled;
                        switchLoading = false;
                      });
                      snackbar(
                        context,
                        "${user.email} ${user.enabled ? "enabled" : "disabled"}!",
                      );
                    }
                  },
                  icon: switchLoading
                      ? const SizedBox(
                          width: 12,
                          height: 12,
                          child: CircularProgressIndicator(),
                        )
                      : Icon(
                          user.enabled ? Icons.check : Icons.clear,
                          color: user.enabled ? Colors.green : Colors.red,
                        ),
                  tooltip: switchLoading
                      ? "Switching..."
                      : user.enabled
                          ? "Disable User"
                          : "Enable User",
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.grey,
          height: 0.5,
        ),
      ],
    );
  }
}
