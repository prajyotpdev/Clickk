import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/signin/sign_in_page.dart';

class MyAppBar extends StatelessWidget  implements PreferredSizeWidget {
  String title;

  MyAppBar({super.key,required this.title, });



  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? _user;
    _user = _auth.currentUser;

    return AppBar(
      title: Text(title),
      actions: [
        if (_user != null)
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          ),
      ],
    );
  }
}
