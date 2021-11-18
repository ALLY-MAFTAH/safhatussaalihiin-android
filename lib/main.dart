
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safhatussaalihiin/home.dart';
import 'package:safhatussaalihiin/providers/data_provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DataProvider _dataProvider = DataProvider();

  @override
  void initState() {
  
    _dataProvider.getAllStreams();
    _dataProvider.getAllPictures();
    _dataProvider.getAllVideos();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: _dataProvider),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.brown,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Home(),
        ));
  }
}
