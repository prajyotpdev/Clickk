import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../signin/sign_in_page.dart';

Future<void> registerWithEmailAndPassword(String email, String name,
    String username, String address, String phoneNumber, String role, String profileUrl) async {
  try {
    User? userid = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance
        .collection('userdata')
        .doc(userid!.uid)
        .set({
      'uid': userid.uid,
      'email': email,
      'name': name,
      'username': username,
      'address': address,
      'phoneNumber': phoneNumber,
      'role': role,
      'profileUrl' : profileUrl
    }).then((value) => {
      FirebaseAuth.instance.signOut(),
    });
  } catch (e) {
    print('Error caught');
  }
}
