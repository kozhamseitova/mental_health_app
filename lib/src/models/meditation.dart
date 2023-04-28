import 'package:cloud_firestore/cloud_firestore.dart';

class Meditation {
  final String id;
  final String title;
  final String titleQaz;
  final int duration;
  final bool premium;
  final String image;
  final String link;
  final String category;

  Meditation({
    required this.id,
    required this.title,
    required this.titleQaz,
    required this.duration,
    required this.premium,
    required this.image,
    required this.link,
    required this.category,
  });

  factory Meditation.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return Meditation(
      id: snapshot.id,
      title: data["title"],
      titleQaz: data["titleQaz"],
      duration: data["duration"],
      premium: data["premium"],
      image: data["image"],
      link: data["link"],
      category: data["category"],
    );
  }
}
