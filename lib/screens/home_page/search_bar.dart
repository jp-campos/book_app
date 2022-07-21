import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final ValueChanged<String> onValueChanged;

  const SearchBar(this.onValueChanged);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onValueChanged,
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
