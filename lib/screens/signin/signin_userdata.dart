import 'package:flutter/material.dart';
import 'package:prixz/common/new_page_appbar.dart';
import 'package:prixz/notifiers/session_notifier.dart';
import 'package:prixz/screens/signin/sign_in.dart';
import 'package:prixz/screens/signin/user_data.dart';
import 'package:provider/provider.dart';

class SignInUserData extends StatelessWidget {
  const SignInUserData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: newPageAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Consumer<SessionNotifier>(builder: (context, notifier, child) {
          if (notifier.isLoggedIn) {
            return UserData();
          }
          return Signin();
        }),
      ),
    );
  }
}
