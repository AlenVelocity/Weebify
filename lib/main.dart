import 'package:weebify/services/api.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:weebify/views/anime_details.dart';
import 'package:weebify/views/home.dart';

void main() {
  runApp(const MyApp(key: Key('main')));
}

class MyApp extends StatelessWidget {
  const MyApp({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataService(),
      child: MaterialApp(
        title: 'AnimSearch',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            elevation: 0,
          ),
          primaryColor: Colors.white,
          secondaryHeaderColor: const Color.fromRGBO(255, 222, 89, 1),
        ),
        home: Home(),
        routes: {
          AnimeDetails.routeName: (context) => AnimeDetails(),
        },
      ),
    );
  }
}
