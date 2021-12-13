import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_image/network.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safhatussaalihiin/api.dart';
import 'package:safhatussaalihiin/models/Post.dart';
import 'package:safhatussaalihiin/providers/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:safhatussaalihiin/views/screens/searched_media.dart';

class Search extends StatefulWidget {
  final DataProvider dataObject;

  const Search({required this.dataObject}) : super(key: null);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  DateTime selectedDate = DateTime.now();
  List<Post> filteredPosts = [];
  String tappedDate = DateTime.now().toString();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Widget> listViews = <Widget>[];

  _selectDate(BuildContext context) async {
    print(selectedDate);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2020),
      lastDate: DateTime(3000),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;

        filteredPosts = [];
        for (var i = 0; i < widget.dataObject.posts.length; i++) {
          if (widget.dataObject.posts[i].date ==
              "${selectedDate.toLocal()}".split(' ')[0]) {
            filteredPosts.add(widget.dataObject.posts[i]);
          }
        }

        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return SearchedMedia(
            searchedDate: selectedDate,
            posts: filteredPosts,
          );
        }));
      });
  }

  @override
  void initState() {
    super.initState();
    filteredPosts = [];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _dataObject = Provider.of<DataProvider>(context);

    return Container(
        key: _scaffoldKey,
        child: Column(children: [
          _dataObject.showSearchBar
              ? InkWell(
                  child: Container(
                    height: 65,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    width: MediaQuery.of(context).size.width,
                    child: ListTile(
                      leading: Icon(Icons.today, color: Colors.white),
                      title: Text(
                        "${selectedDate.toLocal()}".split(' ')[0],
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.angleDown,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _selectDate(context);
                    });
                  },
                )
              : Container(),
          Expanded(
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, top: 5, right: 10),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          filteredPosts = [];
                          tappedDate = _dataObject.posts[index].date;
                          for (var i = 0;
                              i < widget.dataObject.posts.length;
                              i++) {
                            if (widget.dataObject.posts[i].date == tappedDate) {
                              filteredPosts.add(widget.dataObject.posts[i]);
                            }
                          }
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return SearchedMedia(
                              searchedDate: tappedDate,
                              posts: filteredPosts,
                            );
                          }));
                        });
                      },
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
                                        _dataObject.posts[index].id.toString()),
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
                                    primary: Colors.black.withOpacity(0.4)),
                                onPressed: () {
                                  setState(() {
                                    _dataObject.saveNetworkImage(api +
                                        "post/picture_file_1/" +
                                        _dataObject.posts[index].id
                                            .toString());
                                  });
                                },
                                icon: Icon(
                                  FontAwesomeIcons.download,
                                  size: 18,
                                  color: Colors.brown[900],
                                ),
                                label: Text("Save",
                                    style:
                                        TextStyle(color: Colors.brown[900]))),
                          )
                              ],
                            ),
                          ),
                          _dataObject.posts[index].pictureFile2 != null
                              ? Card(
                                  color: Colors.grey[300],
                                  elevation: 8,
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Image(
                                          image: NetworkImageWithRetry(api +
                                              "post/picture_file_2/" +
                                              _dataObject.posts[index].id
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
                                    primary: Colors.black.withOpacity(0.4)),
                                onPressed: () {
                                  setState(() {
                                    _dataObject.saveNetworkImage(api +
                                        "post/picture_file_2/" +
                                        _dataObject.posts[index].id
                                            .toString());
                                  });
                                },
                                icon: Icon(
                                  FontAwesomeIcons.download,
                                  size: 18,
                                  color: Colors.brown[900],
                                ),
                                label: Text("Save",
                                    style:
                                        TextStyle(color: Colors.brown[900]))),
                          )
                                    ],
                                  ),
                                )
                              : Container(),
                          _dataObject.posts[index].pictureFile3 != null
                              ? Card(
                                  color: Colors.grey[300],
                                  elevation: 8,
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Image(
                                          image: NetworkImageWithRetry(api +
                                              "post/picture_file_3/" +
                                              _dataObject.posts[index].id
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
                                    primary: Colors.black.withOpacity(0.4)),
                                onPressed: () {
                                  setState(() {
                                    _dataObject.saveNetworkImage(api +
                                        "post/picture_file_3/" +
                                        _dataObject.posts[index].id
                                            .toString());
                                  });
                                },
                                icon: Icon(
                                  FontAwesomeIcons.download,
                                  size: 18,
                                  color: Colors.brown[900],
                                ),
                                label: Text("Save",
                                    style:
                                        TextStyle(color: Colors.brown[900]))),
                          )
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
                                        _dataObject.posts[index].id.toString(),
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
                            child: TextButton.icon(
                                style: TextButton.styleFrom(
                                    primary: Colors.black.withOpacity(0.4)),
                                onPressed: () {
                                  setState(() {
                                    _dataObject.saveNetworkVideo(api +
                                        "post/video_file_1/" +
                                        _dataObject.posts[index].id
                                            .toString());
                                  });
                                },
                                icon: Icon(
                                  FontAwesomeIcons.download,
                                  size: 18,
                                  color: Colors.brown[900],
                                ),
                                label: Text("Save",
                                    style:
                                        TextStyle(color: Colors.brown[900]))),
                          )
                              ],
                            ),
                          ),
                          _dataObject.posts[index].videoFile2 != null
                              ? Card(
                                  color: Colors.grey[300],
                                  elevation: 8,
                                  child: Column(
                                    children: [
                                      Container(
                                        child: BetterPlayer.network(
                                          api +
                                              "post/video_file_2/" +
                                              _dataObject.posts[index].id
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
                            child: TextButton.icon(
                                style: TextButton.styleFrom(
                                    primary: Colors.black.withOpacity(0.4)),
                                onPressed: () {
                                  setState(() {
                                    _dataObject.saveNetworkVideo(api +
                                        "post/video_file_2/" +
                                        _dataObject.posts[index].id
                                            .toString());
                                  });
                                },
                                icon: Icon(
                                  FontAwesomeIcons.download,
                                  size: 18,
                                  color: Colors.brown[900],
                                ),
                                label: Text("Save",
                                    style:
                                        TextStyle(color: Colors.brown[900]))),
                          )
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  );
                }, childCount: _dataObject.posts.length)),
              ],
            ),
          )
        ]));
  }
}
