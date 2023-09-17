
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth{
  final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context
  })
  async {
    try{
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? currentUser = _firebaseAuth.currentUser ;
      if (currentUser != null) {
        // Successfully logged in, navigate to the /dashboard route
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        // Handle the case where currentUser is null (login failed)
        print("Login failed.");
      }
    }catch (e) {
      // Handle any errors that occur during login
      print("Error during login: $e");
    }

  }

  // static Future<User?> signInWithGoogle({required BuildContext context}) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user;
  //
  //   if (kIsWeb) {
  //     GoogleAuthProvider authProvider = GoogleAuthProvider();
  //
  //     try {
  //       final UserCredential userCredential =
  //       await auth.signInWithPopup(authProvider);
  //
  //       user = userCredential.user;
  //     } catch (e) {
  //       print(e);
  //     }
  //   } else {
  //     final GoogleSignIn googleSignIn = GoogleSignIn();
  //
  //     final GoogleSignInAccount? googleSignInAccount =
  //     await googleSignIn.signIn();
  //
  //     if (googleSignInAccount != null) {
  //       final GoogleSignInAuthentication googleSignInAuthentication =
  //       await googleSignInAccount.authentication;
  //
  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleSignInAuthentication.accessToken,
  //         idToken: googleSignInAuthentication.idToken,
  //       );
  //
  //       try {
  //         final UserCredential userCredential =
  //         await auth.signInWithCredential(credential);
  //
  //         user = userCredential.user;
  //       } on FirebaseAuthException catch (e) {
  //         if (e.code == 'account-exists-with-different-credential') {
  //           // ...
  //         } else if (e.code == 'invalid-credential') {
  //           // ...
  //         }
  //       } catch (e) {
  //         // ...
  //       }
  //     }
  //   }
  //
  //   return user;
  // }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String fname,
    required String sname,
    // required String firstName,
    // required String lastName,
    // required int gender,
    // required int age,

  })
  async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }


  static Future<void> signOut({required BuildContext context}) async {
    // final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      // if (!kIsWeb) {
      //   await googleSignIn.signOut();
      // }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      Print('Somthign is wrong');
    }
  }

  SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  static void Print(String s) {
    if (kDebugMode) {
      print("have yor print");
    }
  }
}