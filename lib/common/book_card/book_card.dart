import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:prixz/common/book_card/color_helper.dart';
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

const loadedAnimationDuration = 500;

class _BookCardState extends State<BookCard>
    with SingleTickerProviderStateMixin {
  final defaultCardColor = Colors.blueGrey.shade200;
  ByteData? imageData;
  bool hasNoThumbnail = false;

  late AnimationController controller;
  late Color cardColor;
  @override
  void initState() {
    super.initState();
    cardColor = defaultCardColor;
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: loadedAnimationDuration));

    fetchImage();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
        setState(() {
          cardColor = tintAvgColor;
          controller.forward();
        });

        return;
      }
    }
    setState(() {
      hasNoThumbnail = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorTween? colorTween;
    if (cardColor != defaultCardColor) {
      colorTween = ColorTween(begin: defaultCardColor, end: cardColor);
    }
    return GestureDetector(
      onTap: () => onBookTaped(widget.model),
      child: AnimatedBuilder(
          animation: controller,
          builder: (context, widget) {
            return Container(
              decoration: ShapeDecoration(
                  shadows: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 5))
                  ],
                  color: colorTween?.evaluate(controller) ?? cardColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              child: content(context),
            );
          }),
    );
  }

  Row content(BuildContext context) {
    return Row(
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
            child: bookInfo(context),
          ),
        ),
      ],
    );
  }

  Column bookInfo(BuildContext context) {
    return Column(
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
        firstChild:
            const Image(image: AssetImage('assets/cover_placeholder.png')),
        secondChild: hasImageLoaded
            ? Image.memory(byte.buffer.asUint8List())
            : SizedBox.shrink(),
        crossFadeState: hasImageLoaded
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: Duration(milliseconds: loadedAnimationDuration));
  }
}
