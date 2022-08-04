import 'package:flutter/material.dart';

const _valueTextStyle = TextStyle(
  color: Colors.white,
  shadows: [Shadow(blurRadius: 2)],
);
const _labelTextStyle = TextStyle(fontSize: 12);

class LibraryCardPair extends StatelessWidget {
  final String label;
  final String value;
  const LibraryCardPair({required this.label, required this.value, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          this.label,
          style: _labelTextStyle,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          this.value,
          softWrap: true,
          style: _valueTextStyle,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
