import 'package:prixz/domain/book.dart';

Book bookFromMap(Map<String, dynamic> map) {
  ;

  return Book(
    id: map['key'],
    title: map['title'],
    author: map['author_name']?[0],
    firstPublishYear: map['first_publish_year'].toString(),
    numberOfPagesMedian: map['number_of_pages_median'],
    subjects: map['subject']?.map<String>((e) => e.toString()).toList(),
    languages: map['language']?.map<String>((e) => e.toString()).toList(),
    thumbnail: _getCover(map, 'S'),
    cover: _getCover(map, 'M'),
  );
}

String? _getCover(Map<String, dynamic> map, String size) {
  return map['cover_i'] != null
      ? 'https://covers.openlibrary.org/b/id/${map['cover_i']}-$size.jpg'
      : null;
}
