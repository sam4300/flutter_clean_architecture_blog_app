import 'package:blog_app/features/blog/domain/entity/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.title,
    required super.content,
    required super.updatedAt,
    required super.imageUrl,
    required super.topics,
    required super.posterId,
    super.name,
  });

  BlogModel copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? updatedAt,
    String? imageUrl,
    List<String>? topics,
    String? posterId,
    String? name,
  }) {
    return BlogModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      updatedAt: updatedAt ?? this.updatedAt,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      posterId: posterId ?? this.posterId,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'updated_at': updatedAt.toIso8601String(),
      'image_url': imageUrl,
      'topics': topics,
      'poster_id': posterId,
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      updatedAt: map['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['updated_at']),
      imageUrl: map['image_url'] ?? '',
      topics: List<String>.from(map['topics'] ?? []),
      posterId: map['poster_id'] ?? '',
    );
  }
}
