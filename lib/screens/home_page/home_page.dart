import 'package:flutter/material.dart';
import 'package:prixz/common/book_card/book_card.dart';
import 'package:prixz/notifiers/books_notifier.dart';
import 'package:prixz/notifiers/session_notifier.dart';
import 'package:prixz/screens/home_page/search_bar.dart';
import 'package:prixz/screens/signin/signin_userdata.dart';
import 'package:prixz/services/book/book_service.dart';
import 'package:provider/provider.dart';

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
      body: ChangeNotifierProvider(
        create: (context) => BooksNotifier(BookService()),
        child: SafeArea(child: body()),
      ),
    );
  }

  Widget body() {
    return Column(
      children: [
        SizedBox(height: 20),
        Builder(builder: (context) {
          return SearchBar((value) =>
              Provider.of<BooksNotifier>(context, listen: false)
                  .searchBooks(value));
        }),
        Expanded(
          child: Consumer<BooksNotifier>(
            builder: (context, booksNotifier, child) {
              if (booksNotifier.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (booksNotifier.searchedBooks.isEmpty) {
                return Center(
                  child: Text(
                    'No hay libros aún',
                    style: Theme.of(context).textTheme.overline,
                  ),
                );
              }

              return ListView.builder(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                  itemCount: booksNotifier.searchedBooks.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        BookCard(
                          model: booksNotifier.searchedBooks[i],
                        ),
                        SizedBox(height: 40),
                      ],
                    );
                  });
            },
          ),
        ),
      ],
    );
  }

  Widget signInWidget() {
    return Consumer<SessionNotifier>(builder: (context, notifier, child) {
      return TextButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => SignInUserData())),
        style: ButtonStyle(),
        child: notifier.isLoggedIn ? Text('Perfil') : Text('Regístrate'),
      );
    });
  }
}
