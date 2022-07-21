int getAge(String birthDate) {
  final b = DateTime.parse(birthDate);
  final now = DateTime.now();
  final bYear = b.year;
  final bMonth = b.month;
  final bDay = b.day;

  final birthdDay = DateTime(now.year, bMonth, bDay);

  var age = now.year - bYear;

  if (birthdDay.isAfter(now)) {
    age--;
  }

  return age;
}
