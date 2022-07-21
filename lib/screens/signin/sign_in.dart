import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prixz/common/gender_constants.dart';
import 'package:prixz/domain/user.dart';
import 'package:prixz/notifiers/session_notifier.dart';
import 'package:provider/provider.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    final sessionProvider =
        Provider.of<SessionNotifier>(context, listen: false);
    final uBuilder = sessionProvider.userBuilder;

    final dateEditingController = TextEditingController();
    return SingleChildScrollView(
      child: Column(
        children: [
          Text('Llena tus datos', style: Theme.of(context).textTheme.headline4),
          SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  onChanged: (value) {
                    uBuilder.names = value;
                  },
                  validator: nonNull,
                  decoration: InputDecoration(hintText: 'Nombres'),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[ a-zA-Záéíóúñ]+'))
                  ],
                ),
                TextFormField(
                  onChanged: (value) {
                    uBuilder.surnames = value;
                  },
                  validator: nonNull,
                  decoration: InputDecoration(hintText: 'Apellidos'),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[ a-zA-Záéíóúñ]+'))
                  ],
                ),
                TextFormField(
                  onChanged: (value) {
                    uBuilder.phone = value;
                  },
                  validator: nonNull,
                  decoration: InputDecoration(hintText: 'Celular'),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                TextFormField(
                  onChanged: (value) {
                    uBuilder.email = value;
                  },
                  decoration: InputDecoration(hintText: 'Correo Electrónico'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value != null &&
                        RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value)) {
                      return null;
                    }
                    return 'Correo no válido';
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Fecha de nacimiento'),
                  readOnly: true,
                  controller: dateEditingController,
                  onTap: () => showCalendar(uBuilder, dateEditingController),
                ),
                DropdownButtonFormField<String>(
                  onChanged: (value) {
                    uBuilder.gender = value;
                  },
                  validator: nonNull,
                  hint: Text('Género'),
                  items: [masculino, femenino, otro]
                      .map<DropdownMenuItem<String>>(
                          (e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      sessionProvider.signIn();
                    }
                  },
                  child: Text('Registrarse'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String? nonNull(value) {
    if (value != null && value != "") {
      return null;
    }
    return 'Ingrese un valor';
  }

  void showCalendar(
      UserBuilder uBuilder, TextEditingController editingController) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: CalendarDatePicker(
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1920),
                  lastDate: DateTime.now(),
                  onDateChanged: (date) {
                    uBuilder.birthDate = date.toString();

                    final dateS = date.toString().split(' ')[0];
                    editingController.text = dateS;

                    Navigator.pop(context);
                  }));
        });
  }
}
