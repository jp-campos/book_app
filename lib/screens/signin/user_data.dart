import 'package:flutter/material.dart';
import 'package:prixz/common/gender_constants.dart';
import 'package:prixz/common/info_pair.dart';
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
          children: [
            Text('Hola ${currUser.names} ${currUser.surnames}'),
            InfoPair(
                title: 'Celular', value: currUser.phone, icon: Icons.phone),
            InfoPair(title: 'Email', value: currUser.email, icon: Icons.email),
            InfoPair(
                title: 'Cumpleaños',
                value: currUser.birthDate,
                icon: Icons.cake),
            InfoPair(
                title: 'Edad',
                value: currUser.age.toString(),
                icon: Icons.elderly),
            InfoPair(
              title: 'Género',
              value: currUser.gender,
              icon: iconGender(currUser.gender),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  notifier.signOut();
                },
                child: Text('Cerrar Sesión'))
          ],
        ),
      );
    });
  }

  IconData iconGender(String gender) {
    switch (gender) {
      case masculino:
        return Icons.male;
      case femenino:
        return Icons.female;
      default:
        return Icons.transgender;
    }
  }
}
