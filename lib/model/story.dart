class Story {
  late String title;
  late String image;
  late String details;

  Story();

  Story.fromMap(Map<String, dynamic> documentMap) {
    title = documentMap['title'];
    image = documentMap['image'];
    details = documentMap['details'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['title'] = title;
    map['image'] = image;
    map['details'] = details;
    return map;
  }
}