import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIconConstraints: BoxConstraints(minHeight: 20, minWidth: 50),
        prefixIcon: Icon(
          Icons.search,
          size: 30,
        ),
        isDense: true,
        hintText: 'Busca por título o autor',
      ),
    );
  }
}
