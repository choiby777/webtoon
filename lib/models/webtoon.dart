class WebToon {
  final String title;
  final String thumb;
  final String id;

  WebToon.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'thumb': thumb,
        'id': id,
      };
}
