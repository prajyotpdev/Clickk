
import 'package:clickk/utils/constant.dart';
import 'package:clickk/views/auth/signin/widgets/GoogleSignIn.dart';
import 'package:clickk/views/dashboard/dash_board.dart';
import 'package:clickk/views/job_profile/ProfilePage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../services/auth.dart';
import '../forgotpassword/forgot_password_page.dart';
import '../signup/sign_up_page.dart';

class LoginPage extends StatefulWidget {



  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String? errorMessage='';
  bool isLogin=true;
  List gender=["Male","Female","Other"];

  String? select;


  final TextEditingController _controllerEmail=TextEditingController();
  final TextEditingController _controllerPassword= TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscureText = true;
  // final TextEditingController _controllerAge= TextEditingController();
  ValueNotifier<int> myCoins = ValueNotifier<int>(10);


  // Future<void> signInWithEmailAndPassword() async{
  //   try {
  //     await Auth().signInWithEmailAndPassword(
  //         email: _controllerEmail.text,
  //         password: _controllerPassword.text, context: context
  //     );
  //
  //   } on FirebaseAuthException catch (e){
  //     setState(() {
  //       errorMessage=e.message;
  //     });
  //   }
  // }

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value){
            setState(() {
              print(value);
              select=value;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        elevation: 10,
        backgroundColor: Color.fromARGB(255, 6, 60, 74),
      ),
      backgroundColor: Color.fromARGB(255, 4, 80, 101),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // Lottie Animation
              Container(
                height: 200,
                child: Lottie.asset('assets/animation_lm0js4z1.json'),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 60, 135, 205),
                      Color.fromARGB(255, 28, 189, 168)!
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          prefixIcon: Icon(
                            Icons.email,
                            color: Color.fromARGB(255, 190, 101, 19),
                          ),
                          fillColor: Color.fromARGB(173, 212, 189, 189),
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Invalid email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          filled: true,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 54, 184, 19),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                          fillColor: Color.fromARGB(173, 212, 189, 189),
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),

                      ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            User? currentUser = FirebaseAuth.instance.currentUser;
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                              // Navigate to the homepage upon successful login
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DashBoardPage(),
                                ),
                              );
                            } catch (e) {
                              // Handle login errors here
                              String errorMessage =
                                  "An error occurred. Please check your credentials.";
                              if (e is FirebaseAuthException) {
                                if (e.code == 'user-not-found') {
                                  errorMessage =
                                  "No user found with that email.";
                                } else if (e.code == 'wrong-password') {
                                  errorMessage =
                                  "Wrong password. Please try again.";
                                }
                              }
                              _showErrorDialog(context, errorMessage);
                            } finally {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 6, 60, 74),
                          padding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 24.0,
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Color.fromARGB(255, 6, 60, 74),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Don't have an account? Sign up",
                          style: TextStyle(
                            color: Color.fromARGB(255, 6, 60, 74),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Help',
                          style: TextStyle(
                            color: Color.fromARGB(255, 6, 60, 74),
                            decoration: TextDecoration.underline,
                          ),
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
    );
  }
}


