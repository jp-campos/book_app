import 'package:flutter/material.dart';
import 'package:prixz/screens/signin/library_card/card_pair.dart';

const _cardText =
    TextStyle(color: Colors.white, shadows: [Shadow(blurRadius: 2)]);

class LibraryCard extends StatefulWidget {
  const LibraryCard({Key? key}) : super(key: key);

  @override
  State<LibraryCard> createState() => _LibraryCardState();
}

class _LibraryCardState extends State<LibraryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00B4DB), Color(0xFF0083B0)],
        ),
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LibraryCardPair(
                    label: 'Nombres',
                    value: 'Juan Pablo Camposdfsdfssfsdfsdssss'),
                LibraryCardPair(label: 'Celular', value: '56456456'),
                LibraryCardPair(label: 'Género', value: 'M')
              ],
            ),
          ),
          Expanded(
              child: Column(
            children: [],
          ))
        ],
      ),
    );
  }
}
