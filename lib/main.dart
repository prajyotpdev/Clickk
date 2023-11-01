// ignore_for_file: avoid_print

import 'package:clickk/firebase_options.dart';
import 'package:clickk/views/auth/signin/sign_in_page.dart';
import 'package:clickk/views/dashboard/dash_board.dart';
import 'package:clickk/views/job_profile/ProfilePage.dart';
import 'package:clickk/views/playground/UIPlayGround.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( 
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(
    child: MaterialApp(
      title: 'Named Routes',
      initialRoute: '/',
      routes: {
        '/': (context) =>  MyApp(),
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const DashBoardPage(),
      },
    ),
  ),);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    print(user?.uid.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/dashboard': (context) =>  DashBoardPage(),
        '/profile': (context) =>  JobProfilePage(),
      },
      home: StreamBuilder(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            print(user?.email);
            return UiPlayGround();
            // if (user == null) {
            //   return LoginPage();
            // } else {
            //   return DashBoardPage();
            // }
          }
          else {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}
