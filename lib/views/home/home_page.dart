import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

import '../../state/currentUser/user_provider.dart';
import '../../utils/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    // final userProvider = Provider.of<UserProvider>(context);

    return
      Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                children: [
                  Container(
                      width: AppGlobals.screenWidth,
                      height: AppGlobals.isDesktop?40:25,
                      padding: EdgeInsets.symmetric(vertical:AppGlobals.isDesktop?10:2),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(color: Color(0xFF4F6AFC)),
                      child:
                      InkWell(
                        onTap:(){
                          Navigator.pushNamed(context, "/login");
                        },
                        child: Marquee(
                          text: '🚀 Give yourself a try - Get A Free Trial !!',
                          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
                          scrollAxis: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          blankSpace: 20.0,
                          velocity: 50.0,
                          pauseAfterRound: Duration(seconds: 1),
                          startPadding: 10.0,
                          accelerationDuration: Duration(seconds: 1),
                          accelerationCurve: Curves.linear,
                          decelerationDuration: Duration(milliseconds: 1000),
                          decelerationCurve: Curves.easeOut,
                        ),
                      )
                  ),
                  Text( 'I am home Screen', overflow: TextOverflow.ellipsis,style: TextStyle(
                      color: Colors.amber
                  ),),
                  ElevatedButton(
                      child: Text("Sign In"), //click me button
                      onPressed: (){
                        Navigator.pushNamed(context, "/login");
                      }
                  ),
                ]
            ),
          ),
        ),
      );
  }
}
