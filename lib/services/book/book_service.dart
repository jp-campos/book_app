import 'dart:convert';

import 'package:prixz/domain/book.dart';
import 'package:prixz/domain/book_gateway.dart';
import 'package:http/http.dart' as http;
import 'package:prixz/services/book/book_mapper.dart';

const _endPoint = 'openlibrary.org';

class BookService implements BookGateway {
  @override
  Future<List<Book>> getBooks(String search) async {
    String query = search.replaceAll(' ', '+');
    final uri =
        Uri.https(_endPoint, '/search.json', {'q': query, 'limit': '20'});
    print(uri.toString());
    final response = await http.get(uri);

    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> docs = json['docs'];

    return docs.map<Book>((e) => bookFromMap(e)).toList();
  }

  @override
  Future<String?> getBookDescription(String bookId) async {
    final uri = Uri.https(_endPoint, '$bookId.json');
    print(uri.toString());

    final response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    var description = json['description'];
    if (description is Map) {
      description = description['value'];
    }
    return description;
  }
}
