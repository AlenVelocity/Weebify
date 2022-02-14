class CardModel {
  late int malId;
  late String url;
  late String imageUrl;
  late String title;

  CardModel({
    required this.malId,
    required this.url,
    required this.imageUrl,
    required this.title,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      malId: json['mal_id'],
      url: json['url'],
      imageUrl: json['image_url'],
      title: json['title'],
    );
  }
}
