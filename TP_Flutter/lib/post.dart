class Post {
  String id;
  String title;
  String description;

  Post({
    required this.id,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }
}
