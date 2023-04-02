import 'package:cloud_firestore/cloud_firestore.dart';

class Favorite {
  final String id;
  final String a_id;
  final String title;
  final int duration;
  final bool premium;
  final String image;
  final String link;
  final String category;

  Favorite({
    required this.id,
    required this.a_id,
    required this.title,
    required this.duration,
    required this.premium,
    required this.image,
    required this.link,
    required this.category,
  });

  factory Favorite.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return Favorite(
      id: snapshot.id,
      a_id: data["a_id"],
      title: data["title"],
      duration: data["duration"],
      premium: data["premium"],
      image: data["image"],
      link: data["link"],
      category: data["category"],
    );
  }
}
