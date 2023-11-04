
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/organiser/Organiser.dart';
import '../providers/organiserProviders.dart';

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
  Future<void> retrieveOrganisers() async {
    print('organisers data is getting called');
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("organisors").get();
    print('organisers data retrieved successfully');
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("organisors").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      var organiserData = a.data() as Map<String, dynamic>;
    }
    List<Organiser> organiserList = [];
    final List<Organiser> organiserListToAdd = ref.read(organiserListProvider);
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var doc = querySnapshot.docs[i];
      var organiserData = doc.data() as Map<String, dynamic>;
      print('THis is organiserData fromdatastore $organiserData ');
      var organiser = Organiser(
        id: doc.id,
        eventsList: organiserData['events_List'] as List<dynamic>,
        oDomain: organiserData['o_domain'] as String,
        oInstitute: organiserData['o_institute'] as String,
        oLocation: organiserData['o_location'] as String,
        oName: organiserData['o_name'] as String,
        oSuccessRate: organiserData['o_successRate'] as int, // Corrected field name
        oUrl: organiserData['o_url'] as String,
        uid: organiserData['uid'] as String,
      );
      organiserListToAdd.add(organiser);
    }
  }
}
