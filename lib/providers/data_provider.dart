import 'dart:convert';
import 'dart:async';
// import 'package:path/path.dart' as path;
// ignore: import_of_legacy_library_into_null_safe
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:safhatussaalihiin/api.dart';
import 'package:safhatussaalihiin/models/LiveStream.dart';
import 'package:safhatussaalihiin/models/Picture.dart';
import 'package:safhatussaalihiin/models/Video.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
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
  // ********** PICTURES DATA ***********
  List<Picture> _pictures = [];
  List<Picture> _todayPictures = [];

  List<Picture> get pictures => _pictures;
  List<Picture> get todayPictures => _todayPictures;

  Future<void> getAllPictures() async {
    List<Picture> _fetchedPictures = [];
    try {
      final response = await http.get(Uri.parse(api + 'pictures/'));
      print("hiyo hapo chini");
      print(response.toString());
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        data['pictures'].forEach(($picture) {
          final pictureDataSet = Picture.fromMap($picture);
          _fetchedPictures.add(pictureDataSet);
        });
        _pictures = _fetchedPictures;
        _pictures.forEach(($pic) {
          if ($pic.date == "${today.toLocal()}".split(' ')[0]) {
            print("Kuna hii ya leooooooo" + $pic.date);
            _todayPictures.add($pic);
          }
        });
        notifyListeners();
        print(_fetchedPictures);
        print(_fetchedPictures.length);
        print(_todayPictures);
        print(_todayPictures.length);
      }
    } catch (e) {
      print("Pictures fetching failed");
      print(e);
    }
  }

  //
  //
  //
  // ********** PICTURES DATA ***********
  List<Video> _videos = [];
  List<Video> _todayVideos = [];

  List<Video> get videos => _videos;
  List<Video> get todayVideos => _todayVideos;

  Future<void> getAllVideos() async {
    List<Video> _fetchedVideos = [];
    try {
      final response = await http.get(Uri.parse(api + 'videos/'));
      print("hiyo hapo chini");
      print(response.toString());
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        data['videos'].forEach(($video) {
          final videoDataSet = Video.fromMap($video);
          _fetchedVideos.add(videoDataSet);
        });
        _videos = _fetchedVideos;
        _videos.forEach(($vid) {
          if ($vid.date == "${today.toLocal()}".split(' ')[0]) {
            print("Kuna hii ya leooooooo" + $vid.date);
            _todayVideos.add($vid);
          }
        });
        notifyListeners();
        print(_fetchedVideos);
        print(_fetchedVideos.length);
        print(_todayVideos);
        print(_todayVideos.length);
      }
    } catch (e) {
      print("Videos fetching failed");
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
  // int newPictureIndex = 0;
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
