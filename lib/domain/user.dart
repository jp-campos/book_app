import 'package:prixz/common/helper/date_helper.dart';

class User {
  String names;
  String surnames;
  String email;
  String phone;
  String gender;
  String birthDate;
  int age;

  User({
    required this.names,
    required this.surnames,
    required this.email,
    required this.phone,
    required this.age,
    required this.gender,
    required this.birthDate,
  });
}

class UserBuilder {
  String? names;
  String? surnames;
  String? email;
  String? phone;
  String? gender;
  String? birthDate;
  int? age;

  User build() {
    return User(
        names: names!,
        surnames: surnames!,
        email: email!,
        phone: phone!,
        age: getAge(birthDate!),
        gender: gender!,
        birthDate: birthDate!);
  }
}
