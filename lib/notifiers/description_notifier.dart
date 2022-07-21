import 'package:flutter/material.dart';
import 'package:prixz/domain/book_gateway.dart';

class DescriptionNotifier extends ChangeNotifier {
  bool _disposed = false;
  bool loading = false;
  String? description;
  late final BookGateway _gateway;
  DescriptionNotifier(this._gateway, String bookId) {
    queryDescription(bookId);
  }
  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  void queryDescription(String bookId) async {
    loading = true;
    description = await _gateway.getBookDescription(bookId);
    loading = false;
    notifyListeners();
  }
}
