import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:prixz/common/book_card/color_helper.dart';
import 'package:prixz/common/book_card/loading_thumbnail.dart';
import 'package:prixz/domain/book.dart';
import 'package:prixz/screens/book_detail/book_detail.dart';

class BookCard extends StatefulWidget {
  final Book model;

  const BookCard({
    required this.model,
    Key? key,
  }) : super(key: key);

  @override
  _BookCardState createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  Color cardColor = Colors.blueGrey.shade200;
  ByteData? imageData;
  bool hasNoThumbnail = false;

  @override
  void initState() {
    super.initState();
    fetchImage();
  }

  @override
  void setState(fn) {
    if (this.mounted) {
      super.setState(fn);
    }
  }

  void fetchImage() async {
    final thumbnail = widget.model.thumbnail;

    if (thumbnail != null) {
      imageData = await NetworkAssetBundle(Uri.parse(thumbnail)).load("");

      final Uint8List bytes = imageData!.buffer.asUint8List();
      final pic = img.decodeImage(bytes);
      if (pic != null) {
        final avgColor = getAverageColor(pic);
        final tintAvgColor = lightenColor(avgColor);
        setState(() => cardColor = tintAvgColor);
        return;
      }
    }
    setState(() {
      hasNoThumbnail = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onBookTaped(widget.model),
      child: Container(
        decoration: ShapeDecoration(
            shadows: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 5))
            ],
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  cardColor,
                  cardColor,
                ]),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTapDown: (_) => print('on tap down'),
              onTap: () => onBookTaped(widget.model),
              child: Transform.translate(
                offset: Offset(hasNoThumbnail ? 0 : 10, -15),
                child: Container(
                  width: 60,
                  height: 80,
                  child: thumbnail(imageData),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        widget.model.title,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    Text(
                      widget.model.author ?? '',
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.model.firstPublishYear,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onBookTaped(Book b) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookDetail(book: b)),
    );
  }

  Widget thumbnail(ByteData? byte) {
    bool hasImageLoaded = byte != null;

    if (hasNoThumbnail) {
      return const Image(
        image: AssetImage('assets/cover_placeholder.png'),
      );
    }

    return AnimatedCrossFade(
        firstChild: LoadingThumbnail(),
        secondChild: hasImageLoaded
            ? Image.memory(byte.buffer.asUint8List())
            : SizedBox.shrink(),
        crossFadeState: hasImageLoaded
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: Duration(milliseconds: 600));
  }
}
