class NewsModel {
  final String id;
  final String title;
  final String description;
  final String link;
  final String imageUrl;
  final String publishedDate;
  final String sourceName;
  final String sourceIcon;
  final List<String> category;

  NewsModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.link,
      required this.imageUrl,
      required this.publishedDate,
      required this.sourceName,
      required this.sourceIcon,
      required this.category});

//fromJson Method (Deserialization/decoding)
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    final dynamic categoryData = json['category'];
    final List<dynamic>? categoryList =
        categoryData is List ? categoryData : null;
    return NewsModel(
      id: json['article_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      link: json['link'] ?? '',
      imageUrl: json['image_url'] ?? '',
      publishedDate: json['pubDate'] ?? '',
      sourceName: json['source_name'] ?? '',
      sourceIcon: json['source_icon'] ?? '',
      category: categoryList != null
          ? categoryList.map((e) => e.toString()).toList()
          : [],

      // List<String>.from(json['category'] ?? [])
    );
  }

//toMap Method (Serialization/Incoding)
  Map<String, dynamic> toJson() {
    return {
      'article_id': id,
      'title': title,
      'description': description,
      'link': link,
      'image_url': imageUrl,
      'pubDate': publishedDate,
      'source_name': sourceName,
      'source_icon': sourceIcon,
      'category': category,
    };
  }

// NOTE: It is critical to override equality for List.contains/remove to work correctly.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewsModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
