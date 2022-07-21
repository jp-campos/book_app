import 'package:prixz/domain/book.dart';

abstract class BookGateway {
  Future<List<Book>> getBooks(String search);
  Future<String?> getBookDescription(String bookId);
}
