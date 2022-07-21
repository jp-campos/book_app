import 'package:prixz/domain/user.dart';

User? userFromPrefs(List<String>? prefs) {
  if (prefs != null) {
    return User(
      names: prefs[0],
      surnames: prefs[1],
      phone: prefs[2],
      email: prefs[3],
      birthDate: prefs[4],
      age: int.parse(prefs[5]),
      gender: prefs[6],
    );
  }
  return null;
}

List<String> prefsFromUser(User user) {
  return [
    user.names,
    user.surnames,
    user.phone,
    user.email,
    user.birthDate,
    user.age.toString(),
    user.gender,
  ];
}
