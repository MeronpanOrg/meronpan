class Chapter {
  final String url;
  final String name;
  final int dateUpload;
  final double chapterNumber;
  final String scanlator;

  Chapter({
    required this.url,
    required this.name,
    required this.dateUpload,
    required this.chapterNumber,
    this.scanlator = '',
  });
}
