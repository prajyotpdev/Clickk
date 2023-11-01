// use amplify query and add function to get and push the data from and to the backend

import 'package:clickk/state/organiser/providers/organiserProviders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/organiser/Organiser.dart';

final organiserDatastoreServiceProvider =
Provider<OrganiserDatastoreService>((ref) {
  final service = OrganiserDatastoreService(ref);
  return service;
});

// fetch previous companies details from the backend

class OrganiserDatastoreService {
  final Ref ref;
  OrganiserDatastoreService(this.ref);
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> addNewOrganiser(Organiser organiser) async {
    try {
      await _db.collection("organisors").add(organiser.toMap());
    } on Exception catch (error) {
      debugPrint(
        'This is error  :  ${error.toString()} and this is error dialog',
      );
    }
  }
  Future<List<Organiser>> retrieveOrganisers() async {
    print('organisers data is getting called');
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("organisors").get();
    print('organisers data retrieved successfully');
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("organisors").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      print(a.data());
    }
    List<Organiser> organiserList = [];
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var doc = querySnapshot.docs[i];
      var organiserData = doc.data() as Map<String, dynamic>;
      var organiser = Organiser(
        id: doc.id,
        eventsList: organiserData['events_list'] as List<String>,
        oDomain: organiserData['o_domain'] as String,
        oInstitute: organiserData['o_institute'] as String,
        oLocation: organiserData['o_location'] as String,
        oName: organiserData['o_name'] as String,
        oSuccessRate: organiserData['o_success_rate'] as String, // Corrected field name
        oUrl: organiserData['o_url'] as String,
        uid: organiserData['uid'] as String,
      );
      organiserList.add(organiser);
    }

    print(organiserList);
    return organiserList;
  }
}
