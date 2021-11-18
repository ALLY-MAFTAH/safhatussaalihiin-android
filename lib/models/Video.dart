class Video {
  final int id;
  final String date;
  final String file;
  final String title;
  final int monthId;

  Video({
    required this.id,
    required this.date,
    required this.file,
    required this.title,
    required this.monthId,
  });

  Video.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['file'] != null),
        assert(map['title'] != null),
        assert(map['month_id'] != null),
        assert(map['date'] != null),
        id = map['id'],
        file = map['file'],
        title = map['title'],
        monthId = map['month_id'],
        date = map['date'];
}
