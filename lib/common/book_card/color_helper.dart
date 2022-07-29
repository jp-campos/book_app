import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

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
  return Color.fromRGBO(
      sqrt(r / n).toInt(), sqrt(g / n).toInt(), sqrt(b / n).toInt(), 1);
}

Color lightenColor(Color c) {
  final rt = c.red + (0.75 * (255 - c.red)).toInt();
  final gt = c.green + (0.75 * (255 - c.green)).toInt();
  final bt = c.blue + (0.75 * (255 - c.blue)).toInt();

  return new Color.fromRGBO(rt, gt, bt, 1);
}
