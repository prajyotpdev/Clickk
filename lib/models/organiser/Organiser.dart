import 'package:cloud_firestore/cloud_firestore.dart';

class Organiser {
  final String? id;
  final List<dynamic> eventsList;
  final String oDomain;
  final String oInstitute;
  final String oLocation;
  final String oName;
  final int oSuccessRate;
  final String oUrl;
  final String uid;

  Organiser({
    this.id,
    required this.eventsList,
    required this.oDomain,
    required this.oInstitute,
    required this.oLocation,
    required this.oName,
    required this.oSuccessRate,
    required this.oUrl,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      'events_List': eventsList,
      'o_domain': oDomain,
      'o_institute': oInstitute,
      'o_location': oLocation,
      'o_name': oName,
      'o_successRate': oSuccessRate,
      'o_url': oUrl,
      'uid': uid,
    };
  }


  Organiser.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        eventsList = doc.data()!["events_List"],
        oDomain = doc.data()!["o_domain"],
        oInstitute = doc.data()!["o_institute"],
        oLocation = doc.data()!["o_location"],
        oName = doc.data()!["o_name"],
        oSuccessRate = doc.data()!["o_successRate"],
        oUrl = doc.data()!["o_url"],
        uid = doc.data()!["uid"]
            .cast<String>();
}
