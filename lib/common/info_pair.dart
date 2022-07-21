import 'package:flutter/material.dart';

class InfoPair extends StatelessWidget {
  final String title;
  final String? value;
  final IconData icon;
  const InfoPair({
    required this.title,
    required this.value,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final content = value;
    if (content != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                  size: 18,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28),
              child: Text(content),
            ),
          ],
        ),
      );
    }
    return SizedBox.shrink();
  }
}
