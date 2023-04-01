import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mental_health_app/src/models/user_data.dart';
import 'package:mental_health_app/src/services/db_service.dart';

class AppointmentRequest {
  String id;
  String description;
  String from;
  String to;
  String status;
  String contact;
  String fromName;
  String toName;

  AppointmentRequest({
    required this.id,
    required this.description,
    required this.from,
    required this.to,
    required this.status,
    required this.contact,
    required this.fromName,
    required this.toName,
  });


  factory AppointmentRequest.fromFirestore(DocumentSnapshot snapshot)  {
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return AppointmentRequest(
      id: snapshot.id,
      description: data["description"],
      from: data["from"],
      to: data["to"],
      status: data["status"],
      contact: data["contact"],
      fromName: data["from_name"],
      toName: data["to_name"],
    );
  }

}
