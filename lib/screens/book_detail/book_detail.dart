import 'package:flutter/material.dart';
import 'package:prixz/common/info_pair.dart';
import 'package:prixz/common/new_page_appbar.dart';
import 'package:prixz/domain/book.dart';
import 'package:prixz/notifiers/description_notifier.dart';
import 'package:prixz/screens/book_detail/expandable_text.dart';
import 'package:prixz/services/book/book_service.dart';
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
        appBar: newPageAppBar(context),
        body: ChangeNotifierProvider<DescriptionNotifier>(
          create: (context) =>
              DescriptionNotifier(BookService(), widget.book.id),
          child: body(context),
        ));
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
          InfoPair(title: 'Autor', value: widget.book.author, icon: Icons.edit),
          InfoPair(
              title: 'Primer año de publicación',
              value: widget.book.firstPublishYear,
              icon: Icons.calendar_today_outlined),
          InfoPair(
              title: '# de páginas',
              value: widget.book.numberOfPagesMedian?.toString(),
              icon: Icons.auto_stories),
        ],
      ),
    );
  }

  Widget info(String title, String? content, IconData icon) {
    if (content != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
          ],
        ),
      );
    }

    return SizedBox.shrink();
  }
}
