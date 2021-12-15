import 'dart:convert';
import 'dart:async';
import 'dart:typed_data';
// import 'package:path/path.dart' as path;
// ignore: import_of_legacy_library_into_null_safe
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safhatussaalihiin/api.dart';
import 'package:safhatussaalihiin/models/LiveStream.dart';
import 'package:safhatussaalihiin/models/Post.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  bool showSearchBar = false;
  bool isPageLoading = false;
  String downloadButtonText = "Save";
  String mediaNameOnDownlod = "";
  DateTime today = DateTime.now();
  //
  //
  //
  // ********** STREAMS DATA ***********
  List<LiveStream> _streams = [];
  List<String> _radioList = [];

  List<LiveStream> get streams => _streams;
  List<String> get radioList => _radioList;
  set setStreams(List emptyStreams) => _streams = [];
  set setRadioList(List emptyRadioList) => _radioList = [];

  Future<void> getAllStreams() async {
    List<LiveStream> _fetchedStreams = [];
    try {
      final response = await http.get(Uri.parse(api + 'streams/'));
      print("hiyo hapo chini");
      print(response.toString());
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        data['streams'].forEach(($stream) {
          final streamDataSet = LiveStream.fromMap($stream);
          _fetchedStreams.add(streamDataSet);
        });
        _streams = _fetchedStreams;
        _streams.forEach(($radio) {
          _radioList.add($radio.type);
        });
        print(_fetchedStreams);
        print(_fetchedStreams.length);
        print(_radioList.toString());
        notifyListeners();
      }
    } catch (e) {
      print("Stream fetching failed");
      print(e);
    }
  }

  //
  //
  //
  // ********** POSTS DATA ***********
  List<Post> _posts = [];
  List<Post> _todayPosts = [];

  List<Post> get posts => _posts;
  List<Post> get todayPosts => _todayPosts;
  set setPosts(List emptyPosts) => _posts = [];
  set setTodayPosts(List todayPosts) => _todayPosts = [];

  Future<void> getAllPosts() async {
    List<Post> _fetchedPosts = [];
    try {
      final response = await http.get(Uri.parse(api + 'posts/'));
      print("hiyo hapo chini");
      print(response.toString());
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        data['posts'].forEach(($post) {
          final postDataSet = Post.fromMap($post);
          _fetchedPosts.add(postDataSet);
        });
        _posts = _fetchedPosts;
        _posts.forEach(($pic) {
          if ($pic.date == "${today.toLocal()}".split(' ')[0]) {
            print("Kuna hii ya leooooooo" + $pic.date);
            _todayPosts.add($pic);
          }
        });
        notifyListeners();
        print(_fetchedPosts);
        print(_fetchedPosts.length);
        print(_todayPosts);
        print(_todayPosts.length);
      }
    } catch (e) {
      print("Posts fetching failed");
      print(e);
    }
  }

  // DOWNLOAD MANAGER

  void saveNetworkVideo(String fileUrl) async {
    var appDocDir = await getTemporaryDirectory();
    String savePath = appDocDir.path + "/temp.mp4";
    await Dio().download(fileUrl, savePath, onReceiveProgress: (count, total) {
      print((count / total * 100).toStringAsFixed(0) + "%");
      mediaNameOnDownlod = fileUrl;
      downloadButtonText =
          "Saving... " + (count / total * 100).toStringAsFixed(0) + "%";
      notifyListeners();
    });
    final result = await ImageGallerySaver.saveFile(savePath);
    print(result);
    _toastInfo("$result");
    downloadButtonText = "Save";
    mediaNameOnDownlod = "";
    notifyListeners();
  }

  void saveNetworkImage(String pictureUrl) async {
    var response = await Dio()
        .get(pictureUrl, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      quality: 60,
    );
    print(result);
    _toastInfo("$result");
    notifyListeners();
  }

  _toastInfo(String info) {
    Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_LONG);
  }

  requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
    // _toastInfo(info);
  }
}
