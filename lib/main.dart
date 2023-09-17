import 'package:clickk/state/Navigation/router.dart';
import 'package:clickk/state/currentUser/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'utils/constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppGlobals.screenWidth = MediaQuery.of(context).size.width;
    AppGlobals.screenHeight = MediaQuery.of(context).size.height;
    AppGlobals.screenWidth<720?AppGlobals.isDesktop=false:AppGlobals.isDesktop=true;


    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: routes,
      ),
    );
  }
}
