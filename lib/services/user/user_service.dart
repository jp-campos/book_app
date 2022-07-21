import 'package:prixz/domain/user.dart';
import 'package:prixz/domain/user_gateway.dart';
import 'package:prixz/services/user/user_mapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _signedUserKey = 'signedUser';

class UserService implements UserGateway {
  SharedPreferences? prefs;

  @override
  Future<void> signIn(User user) async {
    prefs = prefs ?? await SharedPreferences.getInstance();
    prefs!.setStringList(_signedUserKey, prefsFromUser(user));
  }

  @override
  Future<User?> logedInUser() async {
    prefs = prefs ?? await SharedPreferences.getInstance();
    List<String>? list = prefs!.getStringList(_signedUserKey);
    return userFromPrefs(list);
  }

  @override
  Future<void> logOut() async {
    prefs = prefs ?? await SharedPreferences.getInstance();
    prefs!.remove(_signedUserKey);
  }
}
