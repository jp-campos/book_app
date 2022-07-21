import 'package:flutter/material.dart';
import 'package:prixz/notifiers/session_notifier.dart';
import 'package:prixz/screens/home_page/home_page.dart';
import 'package:prixz/services/user/user_service.dart';
import 'package:prixz/theme/text_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(PrixzBook());
}

class PrixzBook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SessionNotifier(UserService()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Prixz Book app',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          textTheme: textTheme,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
