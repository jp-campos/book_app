import 'package:flutter/material.dart';
import 'package:prixz/domain/book.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({required this.text, Key? key}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String fullText;
  late bool overflows;
  late String currText;
  late bool showMore;

  @override
  void initState() {
    super.initState();
    fullText = widget.text;
    overflows = fullText.length > 100;
    showMore = overflows;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(getText()),
          if (showMore)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    showMore = false;
                  });
                },
                child: Text('Ver más'),
              ),
            )
        ],
      ),
    );
  }

  String getText() {
    if (!showMore || !overflows) {
      return fullText;
    }
    return fullText.substring(0, 100) + '...';
  }
}
