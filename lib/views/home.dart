import 'package:weebify/services/api.dart';
import 'package:weebify/views/anime_grid.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  int _selectedIndex = 0;
  bool searching = false;

  Future<void> getData(String category) async {
    await Provider.of<DataService>(context, listen: false)
        .getHomeData(category: category);
  }

  void searchData(String query) {
    Provider.of<DataService>(context, listen: false).searchData(query);
  }

  Widget _buttonBuilder(String name, int myIndex, String category) {
    return Visibility(
      maintainState: true,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = myIndex;
            getData(category);
          });
        },
        child: FittedBox(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 2.5),
            decoration: BoxDecoration(
              color: _selectedIndex == myIndex
                  ? Colors.white
                  : Color.fromRGBO(255, 222, 89, 1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Color.fromRGBO(255, 222, 89, 1),
                width: .8,
              ),
            ),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: _selectedIndex == myIndex
                    ? Color.fromRGBO(255, 222, 89, 1)
                    : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingSearchAppBar(
        colorOnScroll: Colors.white,
        liftOnScrollElevation: 0,
        elevation: 0,
        hideKeyboardOnDownScroll: true,
        title: Container(),
        hint: 'Search anime or manga',
        iconColor: Color.fromRGBO(255, 222, 89, 1),
        autocorrect: false,
        onFocusChanged: (isFocused) {
          if (!isFocused) {
            setState(() {
              searching = false;
              getData('airing');
            });
          }
        },
        leadingActions: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: IconButton(
                icon: Icon(Icons.home,
                    color: Theme.of(context).secondaryHeaderColor),
                splashRadius: 25,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                    getData('airing');
                  });
                }),
          ),
          //
        ],
        onSubmitted: (query) {
          setState(() {
            _selectedIndex = 0;
            searching = true;
            searchData(query);
          });
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Visibility(
              maintainState: true,
              visible: !searching,
              child: Container(
                height: 25,
                margin: EdgeInsets.only(bottom: 10),
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buttonBuilder('Top', 0, 'airing'),
                    _buttonBuilder('Upcoming', 1, 'upcoming'),
                    _buttonBuilder('Series', 2, 'tv'),
                    _buttonBuilder('Movies', 3, 'movie'),
                    _buttonBuilder('OVA', 4, 'ova'),
                    _buttonBuilder('Special Release', 5, 'special'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: AnimeGrid(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
