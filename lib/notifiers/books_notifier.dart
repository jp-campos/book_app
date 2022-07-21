import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:prixz/domain/book.dart';
import 'package:prixz/domain/book_gateway.dart';
import 'dart:async';

class BooksNotifier extends ChangeNotifier {
  final BookGateway _bookGateWay;
  List<Book> _bookList = [];
  Timer? _debounce;

  bool isLoading = false;

  UnmodifiableListView<Book> get searchedBooks =>
      UnmodifiableListView(_bookList);

  BooksNotifier(this._bookGateWay);

  void searchBooks(String search) async {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    _debounce = Timer(Duration(milliseconds: 500), () async {
      if (search.isNotEmpty) {
        isLoading = true;
        notifyListeners();
        _bookList = await _bookGateWay.getBooks(search);
        isLoading = false;
      } else {
        isLoading = false;
        _bookList = [];
      }
      notifyListeners();
    });
  }
}
