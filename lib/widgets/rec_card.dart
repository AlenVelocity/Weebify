import 'package:flutter/material.dart';
import 'package:weebify/models/recommendation.dart';
import 'package:weebify/views/anime_details.dart';

class RecommendationCard extends StatelessWidget {
  final Recommendation recData;

  RecommendationCard({
    required this.recData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      clipBehavior: Clip.none,
      child: InkWell(
        onTap: () => Navigator.of(context).pushReplacementNamed(
          AnimeDetails.routeName,
          arguments: recData.malId,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  recData.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
              recData.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }
}
