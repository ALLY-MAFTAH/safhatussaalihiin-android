import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safhatussaalihiin/api.dart';
import 'package:safhatussaalihiin/models/Post.dart';

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
                                    "post/file/" +
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
                                    primary: Colors.black.withOpacity(0.4),
                                  ),
                                  onPressed: () {},
                                  icon: Icon(
                                    FontAwesomeIcons.download,
                                    size: 18,
                                    color: Colors.brown[900],
                                  ),
                                  label: Text(widget.posts[index].date,
                                      style:
                                          TextStyle(color: Colors.brown[900]))),
                            )
                          ],
                        )),
                  ],
                ),
              ),
            );
          }, childCount: widget.posts.length)),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) => Card(
                        margin: EdgeInsets.only(
                            left: 15, top: 10, right: 15, bottom: 10),
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
                                // child: VideosPlayer(networkVideos: [
                                //   NetworkVideo(
                                //       postUrl: api +
                                //           "post/file/" +
                                //           _dataObject.posts[index].id
                                //               .toString())
                                // ]),
                                ),
                            Container(
                              color: Colors.brown,
                              height: 1.5,
                            ),
                            Container(
                              child: TextButton.icon(
                                  style: TextButton.styleFrom(
                                    primary: Colors.black.withOpacity(0.4),
                                  ),
                                  onPressed: () {},
                                  icon: Icon(
                                    FontAwesomeIcons.download,
                                    size: 18,
                                    color: Colors.brown[900],
                                  ),
                                  label: Text(widget.posts[index].date,
                                      style:
                                          TextStyle(color: Colors.brown[900]))),
                            )
                          ],
                        ),
                      ),
                  childCount: widget.posts.length)),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(15),
              child: Divider(
                height: 0,
                thickness: 5,
                color: Colors.brown[300],
              ),
            )
          ])),
        ],
      ),
    );
  }
}
