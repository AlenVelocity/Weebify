class Anime {
  late int malId;
  late String url;
  late String imageUrl;
  late String title;
  late String trailerUrl;
  late String titleEnglish;
  late String synopsis;
  late String status;
  late dynamic episodes;
  late String duration;
  late String rating;
  late dynamic score;
  late dynamic rank;
  late String airingDate;
  late dynamic genres;
  late dynamic genreId;

  Anime({
    this.malId = 0,
    this.url = '',
    this.imageUrl = '',
    this.title = '',
    this.trailerUrl = '',
    this.titleEnglish = '',
    this.synopsis = '',
    this.status = '',
    this.episodes = 0,
    this.duration = '',
    this.rating = '',
    this.score = 0,
    this.rank = 0,
    this.airingDate = '',
    this.genres = const [],
    this.genreId = 1,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    List genresList = json['genres'];
    List genres = [];
    for (int i = 0; i < genresList.length; i++) {
      genres.add(json['genres'][i]['name']);
    }
    return Anime(
      malId: json['mal_id'] ?? 0,
      url: json['url'] ?? '',
      imageUrl: json['image_url'] ?? '',
      title: json['title'] ?? '',
      trailerUrl: json['trailer_url'] ?? '',
      titleEnglish: json['title_english'] ?? 'TBA',
      synopsis: json['synopsis'] ?? '',
      status: json['status'] ?? '',
      episodes: json['episodes'] ?? 0,
      duration: json['duration'] ?? '',
      rating: json['rating'] ?? '',
      score: json['score'] ?? 0,
      rank: json['rank'] ?? 0,
      airingDate: json['aired']['string'] ?? '',
      genres: genres,
      genreId: json['genres'][0]['mal_id'],
    );
  }
}
