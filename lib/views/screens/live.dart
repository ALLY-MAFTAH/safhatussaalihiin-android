import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:flutter_radio/flutter_radio.dart';
import 'package:provider/provider.dart';
import 'package:radio_player/radio_player.dart';
import 'package:safhatussaalihiin/api.dart';
import 'package:safhatussaalihiin/providers/data_provider.dart';

class Live extends StatefulWidget {
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
    final _streamObject = Provider.of<DataProvider>(context);
    return Container(
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _streamObject.streams.isNotEmpty
                  ? Card(
                      color: Colors.brown[900],
                      elevation: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amber[100],
                        ),
                        padding: new EdgeInsets.only(left: 15, right: 15),
                        margin: new EdgeInsets.all(20),
                        child: DropdownButton<String>(
                          dropdownColor: Colors.amber[100]!.withOpacity(1),
                          value: _streamObject.radioList[_chosenRadioIndex],
                          elevation: 8,
                          icon: Icon(Icons.radio),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          items: _streamObject.radioList.map((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                          }).toList(),
                          hint: Text(
                            "Chagua Radio",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _chosenRadioIndex = _streamObject.radioList
                                  .indexOf(value.toString());
                              print(_chosenRadioIndex);
                              isPlaying = false;
                            });
                          },
                        ),
                      ),
                    )
                  : Container(
                      height: 50,
                    ),
            ],
          ),
          _streamObject.streams.isEmpty
              ? Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.brown[200],
                      radius: 100,
                      child: Icon(
                        Icons.radio,
                        size: 130,
                        color: Colors.brown[900],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Icon(
                      Icons.warning,
                      color: Colors.red,
                      size: 40,
                    ),
                    Padding(
                      padding: new EdgeInsets.all(20),
                      child: Text(
                        "'Afwan, Hatupo Live Mda Huu !",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    )
                  ],
                )
              : Column(
                  children: [
                    Card(
                      margin: new EdgeInsets.all(20),
                      elevation: 9,
                      child: Image(
                          image: NetworkImageWithRetry(api +
                              'stream/cover/' +
                              _streamObject.streams[_chosenRadioIndex].id
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
                                _streamObject.streams[_chosenRadioIndex].type,
                                _streamObject.streams[_chosenRadioIndex].url,
                                api +
                                    'stream/cover/' +
                                    _streamObject.streams[_chosenRadioIndex].id
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
    );
  }
}
