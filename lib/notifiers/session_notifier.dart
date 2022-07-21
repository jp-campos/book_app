import 'package:flutter/material.dart';
import 'package:prixz/domain/user.dart';
import 'package:prixz/domain/user_gateway.dart';

class SessionNotifier extends ChangeNotifier {
  User? signedInUser;
  UserBuilder userBuilder = UserBuilder();

  UserGateway _gateway;
  bool get isLoggedIn => signedInUser != null;
  SessionNotifier(this._gateway) {
    _queryLogedInUser();
  }

  void signIn() async {
    User u = userBuilder.build();
    await _gateway.signIn(userBuilder.build());
    signedInUser = u;
    notifyListeners();
  }

  void signOut() => {signedInUser = null, notifyListeners()};

  void _queryLogedInUser() async {
    signedInUser = await _gateway.logedInUser();
    if (signedInUser != null) notifyListeners();
  }
}
