import 'package:clickk/state/currentUser/providers/userProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/currentUser/user_provider.dart';
import '../auth/signin/sign_in_page.dart';
import '../dashboard/dash_board.dart';
import '../widgets/BottomNavBar.dart';
import '../widgets/MyAppBar.dart';


class DashBoardPage extends ConsumerStatefulWidget {
  const DashBoardPage({super.key});

  @override
  DashBoardPageState createState() => DashBoardPageState();
}

class DashBoardPageState extends ConsumerState<DashBoardPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  List<Map<String, dynamic>> _experiences = [];
  List<dynamic> _skills = [];
  int _formDone = 0;
  List<Color> skillColors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.purple,
    // Add more colors as needed
  ];


  @override
  void initState() {
    super.initState();
    _getUserData(ref);
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _getUserData(ref);
    super.didChangeDependencies();
  }

  Future<void> _getUserData(WidgetRef ref) async {
    final user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _user = user;
      });
      final userData =
      await _firestore.collection('userdata').doc(user.uid).get();
      if (userData.exists) {
        final userDataMap = userData.data() as Map<String, dynamic>;

        ref.read(userProvider.notifier).state= userDataMap; // Now you can access the 'email' property from userDataMap
        final currentUser = (ref.watch(userProvider));
        print('User Email: ${currentUser['email']}');
        // Update your widget with the user data
      }
    }
  }

  @override
  Widget build(BuildContext context ) {

    final currentUser = ( ref.watch(userProvider));

    return MaterialApp(
      home: WillPopScope(
        onWillPop: () async {
          // Return true to allow navigation back, return false to prevent it
          return false; // Prevent back navigation
        },
        child: Scaffold(
          appBar: MyAppBar(title: 'Dashboard'),
          backgroundColor: Color.fromARGB(255, 3, 53, 41),
          body: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                // Background Gradient
                Stack(
                  alignment: Alignment
                      .bottomCenter,
                  // Align the white border and shading to the bottom
                  children: [
                    Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/back.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height *
                          0.2, // Match the height of the image container
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.5),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 4.0,
                      color: Colors.white,
                    ),
                  ],
                ),
                // Positioned(
                //   top: 8,
                //   right: 8,
                //   child: IconButton(
                //     icon: Icon(
                //       Icons.edit,
                //       color: Colors.white,
                //     ),
                //     onPressed: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => EditUserDataPage(),
                //         ),
                //       );
                //     },
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.only(top: 100),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 4.0,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage:
                          AssetImage('assets/profile.png'),
                        ),
                      ),
                      SizedBox(height: 4),
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(6),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 161, 216, 211),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  '${currentUser['name'] ?? 'N/A'}',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color:
                                    Color.fromARGB(255, 84, 30, 210),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Center(
                                  child: RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Bio: ',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 0, 0, 0),
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                          '${currentUser['bio'] ?? 'N/A'}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Color.fromARGB(
                                                255, 59, 183, 25),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 6.0),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(16),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(6),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 135, 212, 229),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Education',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        for (var experience
                                        in _experiences)
                                          ListTile(
                                            leading: Icon(
                                              Icons.work,
                                              color: Colors.amber,
                                            ),
                                            title: Text(
                                                'Company: ${experience['companyName'] ??
                                                    'N/A'}'),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  'Company Name: ${experience['companyName'] ??
                                                      'N/A'}',
                                                  style: TextStyle(
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  'Description: ${experience['description'] ??
                                                      'N/A'}',
                                                  style: TextStyle(
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  'Start Date: ${experience['startDate'] ??
                                                      'N/A'}',
                                                  style: TextStyle(
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  'End Date: ${experience['endDate'] ??
                                                      'N/A'}',
                                                  style: TextStyle(
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  'Skills: ${experience['skills'] ??
                                                      'N/A'}',
                                                  style: TextStyle(
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(16),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(6),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 135, 212, 229),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Skills',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Wrap(
                                          spacing: 8.0,
                                          runSpacing: 8.0,
                                          children: _skills
                                              .asMap()
                                              .entries
                                              .map((entry) {
                                            final skill = entry.value;
                                            final skillIndex = entry.key;
                                            final skillColor =
                                            skillColors[skillIndex %
                                                skillColors.length];

                                            return Chip(
                                              label: Text(skill),
                                              backgroundColor: skillColor,
                                              labelStyle: TextStyle(
                                                  color: Colors.white),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(16),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(6),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 135, 212, 229),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Educations',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        for (var experience
                                        in _experiences)
                                          ListTile(
                                            leading: Icon(
                                              Icons.school,
                                              color: Colors.amber,
                                            ),
                                            title: Text(
                                                'Company: ${experience['companyName'] ??
                                                    'N/A'}'),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  'Company Name: ${experience['companyName'] ??
                                                      'N/A'}',
                                                  style: TextStyle(
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  'Description: ${experience['description'] ??
                                                      'N/A'}',
                                                  style: TextStyle(
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  'Start Date: ${experience['startDate'] ??
                                                      'N/A'}',
                                                  style: TextStyle(
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  'End Date: ${experience['endDate'] ??
                                                      'N/A'}',
                                                  style: TextStyle(
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  'Skills: ${experience['skills'] ??
                                                      'N/A'}',
                                                  style: TextStyle(
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigatorExample(),
        ),
      ),
    );
  }
}