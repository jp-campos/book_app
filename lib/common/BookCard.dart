import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String author;
  final String thumbnail;

  const BookCard(
      {required this.title,
      required this.author,
      required this.thumbnail,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image(
            image: NetworkImage(
                'https://covers.openlibrary.org/b/id/240727-S.jpg')),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Text(author),
          ],
        ),
      ],
    );
  }
}
