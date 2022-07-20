import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:prixz/common/book_card/loading_thumbnail.dart';

class BookCard extends StatefulWidget {
  final String title;
  final String author;
  final String thumbnail;

  const BookCard(
      {required this.title,
      required this.author,
      required this.thumbnail,
      Key? key})
      : super(key: key);

  @override
  _BookCardState createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  Color cardColor = Colors.blueGrey;
  ByteData? imageData;
  @override
  void initState() {
    super.initState();
    fetchImage();
  }

  void fetchImage() async {
    imageData = await NetworkAssetBundle(Uri.parse(widget.thumbnail)).load("");

    final Uint8List bytes = imageData!.buffer.asUint8List();
    final pic = img.decodeJpg(bytes);
    if (pic != null) {
      setState(() {
        cardColor = getAverageColor(pic);
      });
    }
  }

  Color getAverageColor(img.Image pic) {
    int n = 0;
    int r = 0;
    int g = 0;
    int b = 0;

    for (int x = 0; x < pic.width; x++) {
      for (int y = 0; y < pic.height; y++) {
        final color = pic.getPixel(x, y);
        r += img.getRed(color) * img.getRed(color);
        g += img.getGreen(color) * img.getGreen(color);
        b += img.getBlue(color) * img.getBlue(color);
        n++;
      }
    }
    print('$r $g $b');
    return Color.fromRGBO(
        sqrt(r / n).toInt(), sqrt(g / n).toInt(), sqrt(b / n).toInt(), 1);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('TODO card tap'),
      child: Container(
        decoration: ShapeDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  cardColor.withOpacity(0.2),
                  cardColor.withOpacity(0.4),
                ]),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => print('tap en el libro'),
              child: Transform.translate(
                offset: Offset(0, -15),
                child: Container(
                  width: 50,
                  child: thumbnail(imageData),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title,
                      style: Theme.of(context).textTheme.headline4),
                  Text(widget.author),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget thumbnail(ByteData? byte) {
    return LoadingThumbnail();
    return byte != null
        ? Image.memory(byte.buffer.asUint8List())
        : Container(
            color: Colors.red,
            height: 58,
            width: 38,
          );
  }
}
