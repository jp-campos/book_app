import 'package:flutter/material.dart';

class LoadingThumbnail extends StatefulWidget {
  const LoadingThumbnail({Key? key}) : super(key: key);

  @override
  State<LoadingThumbnail> createState() => _LoadingThumbnailState();
}

class _LoadingThumbnailState extends State<LoadingThumbnail>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat();

    animation = Tween(begin: -1, end: 1).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (context, widget) {
          return Container(
            height: 58,
            width: 38,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment(animation.value, 0),
              colors: [
                Colors.grey,
                Colors.grey.shade300,
              ],
            )),
          );
        });
  }
}
