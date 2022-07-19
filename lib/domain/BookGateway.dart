import 'package:prixz/domain/Book.dart';

abstract class BookGateway {
  List<Book> getBooks();
}
