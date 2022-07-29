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

    animation = Tween<double>(begin: -3, end: 10).animate(controller);
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
            width: 45,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment(animation.value, 0),
              end: Alignment.centerLeft,
              colors: [
                Colors.grey.shade100,
                Colors.grey.shade500,
              ],
            )),
          );
        });
  }
}
