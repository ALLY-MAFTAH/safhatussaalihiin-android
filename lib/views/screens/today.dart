import 'package:flutter/material.dart';
import 'package:safhatussaalihiin/providers/data_provider.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image/network.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:safhatussaalihiin/api.dart';
import 'package:provider/provider.dart';

class Today extends StatefulWidget {
  final DataProvider dataProvider;
  const Today({Key? key, required this.dataProvider}) : super(key: key);

  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  String todayDateMiylad = '';
  String todayDateHijr = '';
  String dayName = '';
  String hijrMonthName = '';
  String locale = 'ar';

  void initState() {
    // GETTING TODAY'S MIYLAD DATES
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate =
        ", ${dateParse.day}/${dateParse.month}/${dateParse.year}";
    setState(() {
      todayDateMiylad = formattedDate.toString();
      dateParse.weekday == 1
          ? dayName = "Jumatatu"
          : dateParse.weekday == 2
              ? dayName = "Jumanne"
              : dateParse.weekday == 3
                  ? dayName = "Jumatano"
                  : dateParse.weekday == 4
                      ? dayName = "Alhamis"
                      : dateParse.weekday == 5
                          ? dayName = "Ijumaa"
                          : dateParse.weekday == 6
                              ? dayName = "Jumamosi"
                              : dayName = "Jumapili";
    });

    // GETTING TODAY'S HIJR DATES
    HijriCalendar.setLocal(locale);

    var _format = new HijriCalendar.now();

    var currentDate = "${_format.fullDate()}";

    setState(() {
      todayDateHijr = currentDate.toString();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _dataProvider = Provider.of<DataProvider>(context);
    return RefreshIndicator(
      backgroundColor: Colors.brown,
      color: Colors.white,
      onRefresh: _reloadPage,
      child: Container(
        child: Column(
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
              child: Text(
                dayName + todayDateMiylad + " M\n\n" + " " + todayDateHijr,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
                child: _dataProvider.todayPosts.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : CustomScrollView(
                        physics: BouncingScrollPhysics(),
                        slivers: [
                          SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(left: 10, top: 5, right: 10),
                              child: Container(
                                child: Column(
                                  children: [
                                    Card(
                                      color: Colors.grey[300],
                                      elevation: 8,
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Image(
                                              image: NetworkImageWithRetry(api +
                                                  "post/picture_file_1/" +
                                                  _dataProvider
                                                      .todayPosts[index].id
                                                      .toString()),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Container(
                                            color: Colors.brown,
                                            height: 1.5,
                                          ),
                                          Container(
                                              child: TextButton.icon(
                                                  style: TextButton.styleFrom(
                                                      primary: Colors.black
                                                          .withOpacity(0.4)),
                                                  onPressed: () {
                                                    setState(() {
                                                      _dataProvider
                                                          .saveNetworkImage(api +
                                                              "post/picture_file_1/" +
                                                              _dataProvider
                                                                  .todayPosts[
                                                                      index]
                                                                  .id
                                                                  .toString());
                                                    });
                                                  },
                                                  icon: Icon(
                                                    FontAwesomeIcons.download,
                                                    size: 18,
                                                    color: Colors.brown[900],
                                                  ),
                                                  label: Text("Save",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .brown[900]))))
                                        ],
                                      ),
                                    ),
                                    _dataProvider.todayPosts[index]
                                                .pictureFile2 !=
                                            null
                                        ? Card(
                                            color: Colors.grey[300],
                                            elevation: 8,
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Image(
                                                    image: NetworkImageWithRetry(
                                                        api +
                                                            "post/picture_file_2/" +
                                                            _dataProvider
                                                                .todayPosts[
                                                                    index]
                                                                .id
                                                                .toString()),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.brown,
                                                  height: 1.5,
                                                ),
                                                Container(
                                                  child: TextButton.icon(
                                                      style:
                                                          TextButton.styleFrom(
                                                              primary: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.4)),
                                                      onPressed: () {
                                                        setState(() {
                                                          _dataProvider.saveNetworkImage(api +
                                                              "post/picture_file_2/" +
                                                              _dataProvider
                                                                  .todayPosts[
                                                                      index]
                                                                  .id
                                                                  .toString());
                                                        });
                                                      },
                                                      icon: Icon(
                                                        FontAwesomeIcons
                                                            .download,
                                                        size: 18,
                                                        color:
                                                            Colors.brown[900],
                                                      ),
                                                      label: Text("Save",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.brown[
                                                                      900]))),
                                                )
                                              ],
                                            ),
                                          )
                                        : Container(),
                                    _dataProvider.todayPosts[index]
                                                .pictureFile3 !=
                                            null
                                        ? Card(
                                            color: Colors.grey[300],
                                            elevation: 8,
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Image(
                                                    image: NetworkImageWithRetry(
                                                        api +
                                                            "post/picture_file_3/" +
                                                            _dataProvider
                                                                .todayPosts[
                                                                    index]
                                                                .id
                                                                .toString()),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.brown,
                                                  height: 1.5,
                                                ),
                                                Container(
                                                    child: TextButton.icon(
                                                        style: TextButton
                                                            .styleFrom(
                                                                primary: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.4)),
                                                        onPressed: () {
                                                          setState(() {
                                                            _dataProvider.saveNetworkImage(api +
                                                                "post/picture_file_3/" +
                                                                _dataProvider
                                                                    .todayPosts[
                                                                        index]
                                                                    .id
                                                                    .toString());
                                                          });
                                                        },
                                                        icon: Icon(
                                                          FontAwesomeIcons
                                                              .download,
                                                          size: 18,
                                                          color:
                                                              Colors.brown[900],
                                                        ),
                                                        label: Text("Save",
                                                            style: TextStyle(
                                                                color: Colors
                                                                        .brown[
                                                                    900]))))
                                              ],
                                            ),
                                          )
                                        : Container(),
                                    Card(
                                      color: Colors.grey[300],
                                      elevation: 8,
                                      child: Column(
                                        children: [
                                          Container(
                                            child: BetterPlayer.network(
                                              api +
                                                  "post/video_file_1/" +
                                                  _dataProvider
                                                      .todayPosts[index].id
                                                      .toString(),
                                              betterPlayerConfiguration:
                                                  BetterPlayerConfiguration(
                                                aspectRatio: 16 / 15,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            color: Colors.brown,
                                            height: 1.5,
                                          ),
                                          Container(
                                            child: _dataProvider
                                                        .mediaNameOnDownlod !=
                                                    api +
                                                        "post/video_file_1/" +
                                                        _dataProvider
                                                            .todayPosts[index]
                                                            .id
                                                            .toString()
                                                ? TextButton.icon(
                                                    style: TextButton.styleFrom(
                                                        primary: Colors.black
                                                            .withOpacity(0.4)),
                                                    onPressed: () {
                                                      setState(() {
                                                        _dataProvider
                                                            .saveNetworkVideo(api +
                                                                "post/video_file_1/" +
                                                                _dataProvider
                                                                    .todayPosts[
                                                                        index]
                                                                    .id
                                                                    .toString());
                                                      });
                                                    },
                                                    icon: Icon(
                                                      FontAwesomeIcons.download,
                                                      size: 18,
                                                      color: Colors.brown[900],
                                                    ),
                                                    label: Text("Save",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .brown[900])))
                                                : Center(
                                                    heightFactor: 2,
                                                    child: Text(
                                                        _dataProvider
                                                            .downloadButtonText,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors
                                                                .brown[900])),
                                                  ),
                                          )
                                        ],
                                      ),
                                    ),
                                    _dataProvider
                                                .todayPosts[index].videoFile2 !=
                                            null
                                        ? Card(
                                            color: Colors.grey[300],
                                            elevation: 8,
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: BetterPlayer.network(
                                                    api +
                                                        "post/video_file_2/" +
                                                        _dataProvider
                                                            .todayPosts[index]
                                                            .id
                                                            .toString(),
                                                    betterPlayerConfiguration:
                                                        BetterPlayerConfiguration(
                                                      aspectRatio: 16 / 15,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.brown,
                                                  height: 1.5,
                                                ),
                                                Container(
                                                  child: _dataProvider
                                                              .mediaNameOnDownlod !=
                                                          api +
                                                              "post/video_file_2/" +
                                                              _dataProvider
                                                                  .todayPosts[
                                                                      index]
                                                                  .id
                                                                  .toString()
                                                      ? TextButton.icon(
                                                          style: TextButton.styleFrom(
                                                              primary: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.4)),
                                                          onPressed: () {
                                                            setState(() {
                                                              _dataProvider.saveNetworkVideo(api +
                                                                  "post/video_file_2/" +
                                                                  _dataProvider
                                                                      .todayPosts[
                                                                          index]
                                                                      .id
                                                                      .toString());
                                                            });
                                                          },
                                                          icon: Icon(
                                                            FontAwesomeIcons
                                                                .download,
                                                            size: 18,
                                                            color: Colors
                                                                .brown[900],
                                                          ),
                                                          label: Text("Save",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .brown[900])))
                                                      : Center(
                                                          heightFactor: 2,
                                                          child: Text(
                                                              _dataProvider
                                                                  .downloadButtonText,
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                          .brown[
                                                                      900])),
                                                        ),
                                                )
                                              ],
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            );
                          }, childCount: _dataProvider.todayPosts.length)),
                        ],
                      )),
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
}
