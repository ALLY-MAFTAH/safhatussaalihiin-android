import 'dart:convert';
import 'dart:async';
// import 'package:path/path.dart' as path;
// ignore: import_of_legacy_library_into_null_safe
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:safhatussaalihiin/api.dart';
import 'package:safhatussaalihiin/models/LiveStream.dart';
import 'package:safhatussaalihiin/models/Post.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  bool showSearchBar = false;
  DateTime today = DateTime.now();
  //
  //
  //
  // ********** STREAMS DATA ***********
  List<LiveStream> _streams = [];
  List<String> _radioList = [];

  List<LiveStream> get streams => _streams;
  List<String> get radioList => _radioList;

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

  void saveNetworkVideo(String path) async {
    GallerySaver.saveVideo(path).then((bool? success) {
      print('Video is saved');
    });
    notifyListeners();
  }

  void saveNetworkImage(String path) async {
    GallerySaver.saveImage(path).then((bool? success) {
      print('Image is saved');
    });
    notifyListeners();
  }
}
  // final Dio _dio = Dio();
  // String url = "";
  // String title = "";
  // String progress = "";
  // int newPostIndex = 0;
  // int newVideoIndex = 0;

  // Future<void> downloadCard() async {
  //   Directory? downloadsDirectory = await getExternalStorageDirectory();
  //   downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;
  //   var status = await Permission.storage.status;
  //   if (!status.isGranted) {
  //     await Permission.storage.request();
  //   }

  //   final savePath = path.join(downloadsDirectory.path + "/" + title);

  //   await _startDownload(savePath);
  // }

  // Future<void> _startDownload(String savePath) async {
  //   Map<String, dynamic> result = {
  //     'isSuccess': false,
  //     'filePath': null,
  //     'error': null,
  //   };
  //   await _showDownloadNotification(progress);
  //   try {
  //     final response = await _dio.download(url, savePath,
  //         onReceiveProgress: _onReceiveProgress);
  //     result['isSuccess'] = response.statusCode == 200;
  //     result['filePath'] = savePath;
  //   } catch (ex) {
  //     result['error'] = ex.toString();
  //   } finally {
  //     // progress = "";
  //     notifyListeners();
  //     await _showNotification(result);
  //   }
  // }

  // void _onReceiveProgress(int received, int total) {
  //   if (total != -1) {
  //     progress = (received / total * 100).toStringAsFixed(0) + "%";
  //     notifyListeners();
  //   }
  // }

  // Future<void> cancelDownload() async {
  //   _dio.delete(url);
  // }

  // // *

  // // NOTIFICATION MANAGER

  // Future<void> _showNotification(Map<String, dynamic> downloadStatus) async {
  //   final android = AndroidNotificationDetails(
  //       'channel id', 'channel name', 'channel description',
  //       icon: '@mipmap/safhatussaalihiin',
  //       priority: Priority.high,
  //       importance: Importance.max);
  //   final iOS = IOSNotificationDetails();
  //   final platform = NotificationDetails();
  //   final json = jsonEncode(downloadStatus);
  //   final isSuccess = downloadStatus['isSuccess'];

  //   await flutterLocalNotificationsPlugin.show(
  //       0, // notification id
  //       isSuccess ? 'Maa shaa Allah' : "'Afwan !",
  //       isSuccess
  //           ? 'Umefanikiwa kupakua kadi hii.'
  //           : 'Imeshindikana kupakuwa kadi hii.',
  //       platform,
  //       payload: json);
  // }

  // Future<void> _showDownloadNotification(dPrg) async {
  //   final android = AndroidNotificationDetails(
  //       'channel id', 'channel name', 'channel description',
  //       icon: '@mipmap/safhatussaalihiin',
  //       priority: Priority.high,
  //       importance: Importance.max);
  //   final iOS = IOSNotificationDetails();
  //   final platform = NotificationDetails();

  //   await flutterLocalNotificationsPlugin.show(
  //     1, // notification id
  //     "Downloading ...",
  //     progress,
  //     platform,
  //   );
  // }
// }
