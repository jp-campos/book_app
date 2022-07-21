import 'package:flutter/material.dart';
import 'package:prixz/domain/book.dart';
import 'package:prixz/notifiers/description_notifier.dart';
import 'package:prixz/screens/book_detail/expandable_text.dart';
import 'package:prixz/services/book_service.dart';
import 'package:provider/provider.dart';

class BookDetail extends StatefulWidget {
  final Book book;
  const BookDetail({required this.book, Key? key}) : super(key: key);

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).canvasColor,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back),
            color: Theme.of(context).primaryColor,
          ),
        ),
        body: ChangeNotifierProvider<DescriptionNotifier>(
            create: (context) =>
                DescriptionNotifier(BookService(), widget.book.id),
            child: body(context)));
  }

  Widget body(BuildContext context) {
    final cover = widget.book.cover != null
        ? Image(image: NetworkImage(widget.book.cover!))
        : Image(image: AssetImage('assets/cover_placeholder.png'));
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: cover),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              widget.book.title,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Consumer<DescriptionNotifier>(builder: (context, notifier, child) {
            if (notifier.loading) {
              return LinearProgressIndicator();
            }
            if (notifier.description != null) {
              return ExpandableText(text: notifier.description!);
            }
            return SizedBox.shrink();
          }),
          ...info('Autor', widget.book.author, Icons.edit),
          ...info('Primer año de publicación', widget.book.firstPublishYear,
              Icons.calendar_today_outlined),
          ...info('# de páginas', widget.book.numberOfPagesMedian?.toString(),
              Icons.auto_stories),
        ],
      ),
    );
  }

  Iterable<Widget> info(String title, String? content, IconData icon) {
    if (content != null) {
      return [
        SizedBox(height: 20),
        Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 18,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 28),
          child: Text(content),
        ),
      ].map(
        (e) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: e,
        ),
      );
    }

    return [];
  }
}
