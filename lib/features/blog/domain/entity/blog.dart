class Blog {
  final String id;
  final String title;
  final String content;
  final DateTime updatedAt;
  final String imageUrl;
  final List<String> topics;
  final String posterId;
  final String? name;

  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.updatedAt,
    required this.imageUrl,
    required this.topics,
    required this.posterId,
    this.name
  });

  
}
