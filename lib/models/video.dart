class Video {
  final String id;
  final String title;
  final String thumb;
  final String channel;

  Video({
    required this.id,
    required this.title,
    required this.thumb,
    required this.channel,
  });

  Video.fromJson(Map<String, dynamic> json)
      : id = json['id']['videoId'],
        title = json['snippet']['title'],
        thumb = json['snippet']['thumbnails']['high']['url'],
        channel = json['snippet']['channelTitle'];
}
