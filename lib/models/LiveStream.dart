
class LiveStream {
  final int id;
  final String url;
  final String type;
  final String cover;

  LiveStream({
    required this.id,
    required this.url,
    required this.type,
    required this.cover,
  });

  LiveStream.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['url'] != null),
        assert(map['type'] != null),
        assert(map['cover'] != null),
        id = map['id'],
        url = map['url'],
        type = map['type'],
        cover = map['cover'];
}
