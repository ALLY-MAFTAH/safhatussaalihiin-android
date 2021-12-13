import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:safhatussaalihiin/api.dart';
import 'package:safhatussaalihiin/models/Post.dart';
import 'package:safhatussaalihiin/providers/data_provider.dart';

class SearchedMedia extends StatefulWidget {
  final searchedDate;
  final List<Post> posts;

  const SearchedMedia({
    Key? key,
    required this.searchedDate,
    required this.posts,
  }) : super(key: key);

  @override
  _SearchedMediaState createState() => _SearchedMediaState();
}

class _SearchedMediaState extends State<SearchedMedia> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _dataObject = Provider.of<DataProvider>(context);

    var dateParse = DateTime.parse(widget.searchedDate.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${dateParse.day}/${dateParse.month}/${dateParse.year}" + " Posts",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown[900],
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(left: 10, top: 5, right: 10),
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
                                  widget.posts[index].id.toString()),
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
                                        widget.posts[index].id
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
                    widget.posts[index].pictureFile2 != null
                        ? Card(
                            color: Colors.grey[300],
                            elevation: 8,
                            child: Column(
                              children: [
                                Container(
                                  child: Image(
                                    image: NetworkImageWithRetry(api +
                                        "post/picture_file_2/" +
                                        widget.posts[index].id.toString()),
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
                                          primary:
                                              Colors.black.withOpacity(0.4)),
                                      onPressed: () {
                                        setState(() {
                                          _dataObject.saveNetworkImage(api +
                                              "post/picture_file_2/" +
                                              widget.posts[index].id
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
                                              color: Colors.brown[900]))),
                                )
                              ],
                            ),
                          )
                        : Container(),
                    widget.posts[index].pictureFile3 != null
                        ? Card(
                            color: Colors.grey[300],
                            elevation: 8,
                            child: Column(
                              children: [
                                Container(
                                  child: Image(
                                    image: NetworkImageWithRetry(api +
                                        "post/picture_file_3/" +
                                        widget.posts[index].id.toString()),
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
                                          primary:
                                              Colors.black.withOpacity(0.4)),
                                      onPressed: () {
                                        setState(() {
                                          _dataObject.saveNetworkImage(api +
                                              "post/picture_file_3/" +
                                              widget.posts[index].id
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
                                              color: Colors.brown[900]))),
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
                                  widget.posts[index].id.toString(),
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
                                        widget.posts[index].id
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
                    widget.posts[index].videoFile2 != null
                        ? Card(
                            color: Colors.grey[300],
                            elevation: 8,
                            child: Column(
                              children: [
                                Container(
                                  child: BetterPlayer.network(
                                    api +
                                        "post/video_file_2/" +
                                        widget.posts[index].id.toString(),
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
                                          primary:
                                              Colors.black.withOpacity(0.4)),
                                      onPressed: () {
                                        setState(() {
                                          _dataObject.saveNetworkVideo(api +
                                              "post/video_file_2/" +
                                              widget.posts[index].id
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
                                              color: Colors.brown[900]))),
                                )
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            );
          }, childCount: widget.posts.length)),
        ],
      ),
    );
  }
}
