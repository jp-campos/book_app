import 'package:flutter/material.dart';
import 'package:prixz/common/book_card/book_card.dart';
import 'package:prixz/screens/HomePage/search_bar.dart';

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
            'PrixzBooks',
            style: TextStyle(color: Colors.blue.shade600),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        actions: [signInWidget()],
      ),
      body: SafeArea(child: body()),
    );
  }

  Widget body() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            child:
                Text('Descubre', style: Theme.of(context).textTheme.headline1),
            alignment: Alignment.centerLeft,
          ),
        ),
        SizedBox(height: 20),
        SearchBar(),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
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
