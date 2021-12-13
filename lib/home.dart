import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safhatussaalihiin/providers/data_provider.dart';
import 'package:safhatussaalihiin/views/screens/live.dart';
import 'package:safhatussaalihiin/views/screens/safhatussaalihiin.dart';
import 'package:safhatussaalihiin/views/screens/search.dart';
import 'package:safhatussaalihiin/views/screens/today.dart';

import 'package:share/share.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  String url = "Play store link to the app";

  @override
  Widget build(BuildContext context) {
    final _dataObject = Provider.of<DataProvider>(context);

    List<Widget> _screens = [
      Today(
        dataObject: _dataObject,
      ),
      Search(
        dataObject: _dataObject,
      ),
      Live(),
      Safhatussaalihiin(),
    ];
    return Scaffold(
        backgroundColor: Colors.amber[100]!.withOpacity(1),
        appBar: AppBar(
          backgroundColor: Colors.brown[900],
          toolbarHeight: 45,
          leading: Padding(
            padding: const EdgeInsets.only(
              top: 5,
            ),
            child: Image(
              color: Colors.amber[200],
              image: AssetImage("assets/icons/safhatussaalihiin.png"),
            ),
          ),
          title: _selectedIndex == 0
              ? Text(
                  "Today's Posts",
                  style: TextStyle(color: Colors.white),
                )
              : _selectedIndex == 1
                  ? Text(
                      'Search',
                      style: TextStyle(color: Colors.white),
                    )
                  : _selectedIndex == 2
                      ? Text(
                          'Live Radio',
                          style: TextStyle(color: Colors.white),
                        )
                      : Text(
                          'Safhatussaalihiin',
                          style: TextStyle(color: Colors.white),
                        ),
          actions: [
            _selectedIndex == 3
                ? IconButton(
                    icon: Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Share.share(url);
                    })
                : _selectedIndex == 1
                    ? IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _dataObject.showSearchBar =
                                !_dataObject.showSearchBar;
                          });
                        })
                    : Container()
          ],
        ),
        body: _screens[_selectedIndex],
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: Color.fromRGBO(62, 39, 35, 9),
          // Colors.brown[900]
          buttonBackgroundColor: Colors.brown,
          height: 50,
          animationDuration: Duration(
            milliseconds: 100,
          ),
          index: 0,
          animationCurve: Curves.bounceInOut,
          items: <Widget>[
            Icon(Icons.today, size: 25, color: Colors.white),
            Icon(Icons.search, size: 25, color: Colors.white),
            Icon(Icons.live_tv, size: 25, color: Colors.white),
            Icon(Icons.info, size: 25, color: Colors.white),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ));
  }
}
