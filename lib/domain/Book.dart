class Book {
  final String id;
  final String title;
  final String? author;
  final String firstPublishYear;
  final String? thumbnail;
  final String? cover;
  final List<String>? languages;
  final List<String>? subjects;
  final int? numberOfPagesMedian;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.firstPublishYear,
    required this.thumbnail,
    required this.languages,
    required this.subjects,
    required this.cover,
    this.numberOfPagesMedian,
  });
}
