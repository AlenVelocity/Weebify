import 'package:weebify/models/anime.dart';
import 'package:flutter/material.dart';

class AnimeHeader extends StatelessWidget {
  late final Anime animeData;
  AnimeHeader({required this.animeData});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                animeData.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2.5),
              Text(
                animeData.titleEnglish,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                animeData.airingDate,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                animeData.rating,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                animeData.episodes <= 0
                    ? 'Ongoing'
                    : animeData.episodes.toString() + ' Episodes',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  '${animeData.score}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(255, 222, 89, 1),
                    backgroundColor: Colors.grey.withOpacity(.35),
                    strokeWidth: 6.0,
                    value: animeData.score / 10,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                animeData.rank != 0
                    ? 'Ranked\n #${animeData.rank}'
                    : 'Ranked\n N/A',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
