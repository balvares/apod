class APODEntity {
  final String title;
  final String explanation;
  final String url;
  dynamic date;

  APODEntity({
    required this.title,
    required this.explanation,
    required this.url,
    this.date,
  });
}
