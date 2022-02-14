import 'package:weebify/models/card.dart';
import 'package:weebify/views/anime_details.dart';
import 'package:flutter/material.dart';

class AnimeCard extends StatelessWidget {
  final CardModel homeData;
  final int cardIndex;

  AnimeCard({
    required this.homeData,
    this.cardIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    // final device = MediaQuery.of(context);
    // final screenHeight = device.size.height;
    // final screenWidth = device.size.width;
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        AnimeDetails.routeName,
        arguments: homeData.malId,
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Hero(
                tag: homeData.malId,
                child: Image.network(
                  homeData.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    homeData.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.bookmark_outline,
                    color: Color.fromRGBO(255, 222, 89, 1),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
