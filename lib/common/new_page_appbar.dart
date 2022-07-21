import 'package:flutter/material.dart';

PreferredSizeWidget newPageAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    backgroundColor: Theme.of(context).canvasColor,
    leading: IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: Icon(Icons.arrow_back),
      color: Theme.of(context).primaryColor,
    ),
  );
}
