class Post {
  final int id;
  final String date;
  final String title;
  final String videoFile1;
  final String? videoFile2;
  late final String pictureFile1;
  final String? pictureFile2;
  final String? pictureFile3;

  Post({
    required this.id,
    required this.date,
    required this.title,
    required this.videoFile1,
    required this.videoFile2,
    required this.pictureFile1,
    required this.pictureFile2,
    required this.pictureFile3,
  });

  Post.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['title'] != null),
        assert(map['date'] != null),
        assert(map['picture_file_1'] != null),
        // assert(map['picture_file_2'] ),
        // assert(map['picture_file_3'] ),
        assert(map['video_file_1'] != null),
        // assert(map['video_file_2']),
        id = map['id'],
        title = map['title'],
        date = map['date'],
        pictureFile1 = map['picture_file_1'],
        pictureFile2 = map['picture_file_2'],
        pictureFile3 = map['picture_file_3'],
        videoFile1 = map['video_file_1'],
        videoFile2 = map['video_file_2'];
}
