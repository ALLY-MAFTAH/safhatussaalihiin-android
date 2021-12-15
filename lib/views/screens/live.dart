import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:flutter_radio/flutter_radio.dart';
import 'package:provider/provider.dart';
import 'package:radio_player/radio_player.dart';
import 'package:safhatussaalihiin/api.dart';
import 'package:safhatussaalihiin/providers/data_provider.dart';

class Live extends StatefulWidget {
  final DataProvider dataProvider;
  const Live({Key? key, required this.dataProvider}) : super(key: key);

  @override
  _LiveState createState() => _LiveState();
}

class _LiveState extends State<Live> {
  RadioPlayer _radioPlayer = RadioPlayer();
  bool isPlaying = false;
  List<String>? metadata;
  int _chosenRadioIndex = 0;

  @override
  void initState() {
    initRadioPlayer();

    super.initState();
  }

  void initRadioPlayer() {
    _radioPlayer.stateStream.listen((value) {
      setState(() {
        isPlaying = value;
      });
    });
    _radioPlayer.metadataStream.listen((value) {
      setState(() {
        metadata = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _dataProvider = Provider.of<DataProvider>(context);
    return RefreshIndicator(
      backgroundColor: Colors.brown,
      color: Colors.white,
      onRefresh: _reloadPage,
      child: Container(
        child: _dataProvider.streams.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  Container(
                    height: 65,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PopupMenuButton<String>(
                        initialValue: "Chagua Radio",
                        child: ListTile(
                          title: Text(
                            _dataProvider.streams[_chosenRadioIndex].type,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Icon(Icons.radio,color: Colors.white,),
                        ),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Colors.brown[100],
                        onSelected: choiceAction,
                        itemBuilder: (_) {
                          return _dataProvider.radioList.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(
                                choice,
                                style: TextStyle(
                                    color: Colors.brown[900],
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),

                  // Column(
                  //         children: [
                  //           CircleAvatar(
                  //             backgroundColor: Colors.brown[200],
                  //             radius: 100,
                  //             child: Icon(
                  //               Icons.radio,
                  //               size: 130,
                  //               color: Colors.brown[900],
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             height: 20,
                  //           ),
                  //           Icon(
                  //             Icons.warning,
                  //             color: Colors.red,
                  //             size: 40,
                  //           ),
                  //           Padding(
                  //             padding: new EdgeInsets.all(20),
                  //             child: Text(
                  //               "'Afwan, Hatupo Live Mda Huu !",
                  //               style: TextStyle(
                  //                   color: Colors.red,
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: 20),
                  //             ),
                  //           )
                  //         ],
                  //       ):
                  Column(
                    children: [
                      Card(
                        margin: EdgeInsets.only(left: 13, top: 5, right: 13),
                        elevation: 9,
                        child: Image(
                            image: NetworkImageWithRetry(api +
                                'stream/cover/' +
                                _dataProvider.streams[_chosenRadioIndex].id
                                    .toString())),
                      ),
                      Container(
                        height: 85,
                        width: 85,
                        decoration: BoxDecoration(
                            color: Colors.brown[600],
                            borderRadius: BorderRadius.circular(42.5)),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _radioPlayer.setMediaItem(
                                  _dataProvider.streams[_chosenRadioIndex].type,
                                  _dataProvider.streams[_chosenRadioIndex].url,
                                  api +
                                      'stream/cover/' +
                                      _dataProvider
                                          .streams[_chosenRadioIndex].id
                                          .toString());
                              isPlaying
                                  ? _radioPlayer.pause()
                                  : _radioPlayer.play();
                            });
                          },
                          child: Icon(
                            isPlaying
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            color: Colors.red,
                            size: 80,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> _reloadPage() async {
    setState(() {
      widget.dataProvider.setPosts = [];
      widget.dataProvider.setTodayPosts = [];
      widget.dataProvider.setRadioList = [];
      widget.dataProvider.setStreams = [];
      widget.dataProvider.getAllPosts();
      widget.dataProvider.getAllStreams();
    });
  }

  void choiceAction(String choice) {
    setState(() {
      _chosenRadioIndex =
          widget.dataProvider.radioList.indexOf(choice.toString());
      isPlaying = false;
    });
  }
}
