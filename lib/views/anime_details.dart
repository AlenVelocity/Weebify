import 'package:weebify/models/anime.dart';
import 'package:weebify/services/api.dart';
import 'package:weebify/widgets/genre_details.dart';
import 'package:weebify/widgets/anime_header.dart';
import 'package:weebify/widgets/rec_card.dart';
import 'package:weebify/widgets/webview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimeDetails extends StatefulWidget {
  static const routeName = '/animedetailscreen';

  @override
  _AnimeDetailScreenState createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetails> {
  var _isInit = true;

  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      late int animeId = ModalRoute.of(context)!.settings.arguments as int;
      Provider.of<DataService>(context, listen: false).getAnimeData(animeId);
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataService>(context);
    final Anime animeData = dataProvider.animeData;
    final device = MediaQuery.of(context);
    // final screenHeight = device.size.height;
    final screenWidth = device.size.width;
    return Scaffold(
      floatingActionButton: !dataProvider.isLoading
          ? FloatingActionButton(
              child: const Icon(
                Icons.open_in_browser_outlined,
                color: Colors.white,
              ),
              tooltip: 'Open in browser',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebViewContainer(animeData.url),
                  ),
                );
              },
            )
          : null,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Color.fromRGBO(255, 222, 89, 1),
      body: !dataProvider.isLoading
          ? Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: screenWidth / 1.3,
                  width: screenWidth,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3), BlendMode.multiply),
                    child: Hero(
                      tag: animeData.malId,
                      child: Image.network(
                        animeData.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  color: Color.fromRGBO(255, 222, 89, 1),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.only(top: screenWidth / 1.5),
                  clipBehavior: Clip.none,
                  child: Container(
                    width: screenWidth,
                    // padding: EdgeInsets.all(25).copyWith(top: 35),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25)
                              .copyWith(top: 25),
                          child: AnimeHeader(
                            animeData: animeData,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25)
                              .copyWith(top: 25),
                          child: Text(
                            animeData.synopsis,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                          child: GenreDetails(animeData: animeData),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            'Animes Like This',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          height: screenWidth / 2,
                          width: screenWidth,
                          margin: const EdgeInsets.symmetric(vertical: 15)
                              .copyWith(bottom: 35),
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: dataProvider.recommendationList.length,
                            itemBuilder: (context, index) => RecommendationCard(
                              recData: dataProvider.recommendationList[index],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 5,
            )),
    );
  }
}
