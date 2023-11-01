import 'package:clickk/state/currentUser/providers/userProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/auth.dart';
import '../../state/currentUser/user_provider.dart';
import '../auth/signin/sign_in_page.dart';
import '../dashboard/dash_board.dart';
import '../widgets/BottomNavBar.dart';
import '../widgets/MyAppBar.dart';
import 'widgets/event_carousel.dart';
import 'widgets/event_carousel_demo.dart';


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

    final User? user=Auth().currentUser;

    double width = MediaQuery. of(context). size. width ;
    double height = MediaQuery. of(context). size. height ;

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
            padding: const EdgeInsets.only(top: 50) ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 10,left: 10),
                  child: Container(
                    width: width ,
                    height: height*0.1,
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            radius: 34,
                            backgroundImage:
                            NetworkImage('https://picsum.photos/id/237/200/300'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5,),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Welcome, ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        // text: user?.email?? ''+'Welcome',
                                        text: user!.photoURL,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        // text: user?.email?? ''+'Welcome',
                                        text: ' \u{1F44B}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Image.asset('assets/images/Coin.png',
                                    height: 23.0,
                                    width: 23.0,
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      user?.email?? ''+'Welcome',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),),
                                  ),
                                ],
                              ),
                            ],

                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15,top: 24),
                  child: Text('Contest',
                    style: GoogleFonts.inter(
                        color: Colors.black,
                        fontWeight:FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    height:250,
                    width: width,
                    // child: EventCarouselWidget(),
                    child: EventCarouselWidgetDemo(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15,top: 20),
                  child: Text('Choose a topic',
                    style: GoogleFonts.inter(
                        color: Colors.black,
                        fontWeight:FontWeight.bold,
                        fontSize: 18
                    ),
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