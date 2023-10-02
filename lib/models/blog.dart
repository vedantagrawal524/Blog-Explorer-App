class Blog {
  Blog({
    required this.id,
    required this.title,
    required this.imageUrl,
  });
  final String id;
  final String title;
  final String imageUrl;

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image_url'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image_url': imageUrl,
    };
  }
}
