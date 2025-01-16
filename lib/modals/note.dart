class Notes{
  Notes({required this.title,
    required this.content,
    required this.contentJson,
    required this.tags,
    required this.dateCreated,
    required this.dateModified});
  final String? title;
  final String? content;
  final String contentJson;
  final List<String>? tags;
  final int dateCreated;
  final int dateModified;
}