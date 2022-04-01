import 'package:cloud_firestore/cloud_firestore.dart';

class Blog {
  String imgUrl;
  String title;
  String desc;

  Blog({
    required this.imgUrl,
    required this.title,
    required this.desc
  });

  factory Blog.fromJson(Map<dynamic, dynamic> json) => Blog(
      imgUrl: json["imgUrl"],
      title: json["title"],
      desc: json["desc"]
  );

  Map<String, dynamic> toJson() => {
    "imgUrl": imgUrl,
    "title": title,
    "desc": desc,
  };

  factory Blog.fromDocument(DocumentSnapshot doc) {
    return Blog.fromJson(doc.data());
  }
}