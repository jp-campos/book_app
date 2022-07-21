import 'package:flutter/material.dart';
import 'package:prixz/notifiers/session_notifier.dart';
import 'package:provider/provider.dart';

class UserData extends StatelessWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionNotifier>(builder: (context, notifier, child) {
      final currUser = notifier.signedInUser!;
      return SingleChildScrollView(
        child: Column(
          children: [Text('${currUser.names} ${currUser.surnames}')],
        ),
      );
    });
  }
}
