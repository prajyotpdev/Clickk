import 'package:clickk/views/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';

import '../auth/signin/sign_in_page.dart';
import '../widgets/BottomNavBar.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Role Selection'),
      backgroundColor: Color.fromARGB(255, 3, 53, 41),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.amberAccent,
                shape: BoxShape.circle,
              ),
              child: Text('Sponsor'),
            ),
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.amberAccent,
                shape: BoxShape.circle,
              ),
              child: Text('Organiser'),
            ),
          ],
        )
      ),
      bottomNavigationBar: BottomNavigatorExample(),
    );
  }
}
