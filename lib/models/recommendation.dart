class Recommendation {
  late int malId;
  late String url;
  late String imageUrl;
  late String title;

  Recommendation({
    this.malId = 1,
    this.url = '',
    this.imageUrl = '',
    this.title = '',
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      malId: json['mal_id'] ?? 1,
      url: json['url'] ?? '',
      imageUrl: json['image_url'] ?? '',
      title: json['title'] ?? '',
    );
  }
}
