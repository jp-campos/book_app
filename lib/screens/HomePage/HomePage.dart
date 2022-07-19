import 'package:flutter/material.dart';
import 'package:prixz/common/BookCard.dart';
import 'package:prixz/screens/HomePage/SearchBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text(
            'Hola',
            style: TextStyle(color: Colors.blueGrey),
          ),
        ),
        backgroundColor: Colors.white,
        actions: [signInWidget()],
      ),
      body: SafeArea(child: body()),
    );
  }

  Widget body() {
    return Column(
      children: [
        SearchBar(),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: BookCard(
            title: 'Lord of the Rings',
            author: 'Pepito',
            thumbnail: 'https://covers.openlibrary.org/b/id/240727-S.jpg',
          ),
        ),
      ],
    );
  }

  Widget signInWidget() {
    return TextButton(
      onPressed: () => print('TODO'),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Sign in'),
          IconButton(
            onPressed: () => print('todo'),
            icon: Icon(Icons.login),
          ),
        ],
      ),
    );
  }
}
