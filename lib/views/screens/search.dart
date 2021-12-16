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
  final DataProvider dataProvider;
  const Search({Key? key, required this.dataProvider}) : super(key: key);

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
        for (var i = 0; i < widget.dataProvider.posts.length; i++) {
          if (widget.dataProvider.posts[i].date ==
              "${selectedDate.toLocal()}".split(' ')[0]) {
            filteredPosts.add(widget.dataProvider.posts[i]);
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
    final _dataProvider = Provider.of<DataProvider>(context);

    return RefreshIndicator(
        backgroundColor: Colors.brown,
        color: Colors.white,
        onRefresh: _reloadPage,
        child: CustomScrollView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                slivers: [
                  SliverList(
                      delegate: SliverChildListDelegate(<Widget>[
                    _dataProvider.showSearchBar
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
                  ])),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                    return  _dataProvider.posts.isEmpty
            ? Center(heightFactor: 15, child: CircularProgressIndicator())
            : Padding(
                      padding: EdgeInsets.only(left: 10, top: 5, right: 10),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            filteredPosts = [];
                            tappedDate = _dataProvider.posts[index].date;
                            for (var i = 0;
                                i < widget.dataProvider.posts.length;
                                i++) {
                              if (widget.dataProvider.posts[i].date ==
                                  tappedDate) {
                                filteredPosts.add(widget.dataProvider.posts[i]);
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
                              child: Container(
                                child: Image(
                                  image: NetworkImageWithRetry(api +
                                      "post/picture_file_1/" +
                                      _dataProvider.posts[index].id.toString()),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            _dataProvider.posts[index].pictureFile2 != null
                                ? Card(
                                    color: Colors.grey[300],
                                    elevation: 8,
                                    child: Container(
                                      child: Image(
                                        image: NetworkImageWithRetry(api +
                                            "post/picture_file_2/" +
                                            _dataProvider.posts[index].id
                                                .toString()),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container(),
                            _dataProvider.posts[index].pictureFile3 != null
                                ? Card(
                                    color: Colors.grey[300],
                                    elevation: 8,
                                    child: Container(
                                      child: Image(
                                        image: NetworkImageWithRetry(api +
                                            "post/picture_file_3/" +
                                            _dataProvider.posts[index].id
                                                .toString()),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container(),
                            Card(
                              color: Colors.grey[300],
                              elevation: 8,
                              child: Container(
                                child: BetterPlayer.network(
                                  api +
                                      "post/video_file_1/" +
                                      _dataProvider.posts[index].id.toString(),
                                  betterPlayerConfiguration:
                                      BetterPlayerConfiguration(
                                    aspectRatio: 16 / 15,
                                  ),
                                ),
                              ),
                            ),
                            _dataProvider.posts[index].videoFile2 != null
                                ? Card(
                                    color: Colors.grey[300],
                                    elevation: 8,
                                    child: Container(
                                      child: BetterPlayer.network(
                                        api +
                                            "post/video_file_2/" +
                                            _dataProvider.posts[index].id
                                                .toString(),
                                        betterPlayerConfiguration:
                                            BetterPlayerConfiguration(
                                          aspectRatio: 16 / 15,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    );
                  }, childCount: _dataProvider.posts.length)),
                ],
              ));
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
