import 'package:clickk/views/auth/signup/widgets/registerWithEmailPassword.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../forgotpassword/forgot_password_page.dart';
import '../help/help_page.dart';
import '../signin/sign_in_page.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  bool _isLoading = false;

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
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
                          suffixIcon: Icon(
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
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.pink,
                            ),
                            suffixIcon: Icon(
                              Icons.person,
                              color: Colors.pink,
                            ),
                            fillColor: Color.fromARGB(173, 212, 189, 189),
                            border: OutlineInputBorder(),
                            labelText: 'Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(
                              Icons.verified_user,
                              color: Colors.white,
                            ),
                            suffixIcon: Icon(
                              Icons.verified_user,
                              color: Colors.white,
                            ),
                            fillColor: Color.fromARGB(173, 212, 189, 189),
                            border: OutlineInputBorder(),
                            labelText: 'Username'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(
                              Icons.home,
                              color: Color.fromARGB(255, 50, 8, 155),
                            ),
                            suffixIcon: Icon(
                              Icons.home,
                              color: Color.fromARGB(255, 50, 8, 155),
                            ),
                            fillColor: Color.fromARGB(173, 212, 189, 189),
                            border: OutlineInputBorder(),
                            labelText: 'Address'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.amber,
                            ),
                            suffixIcon: Icon(
                              Icons.phone,
                              color: Colors.amber,
                            ),
                            fillColor: Color.fromARGB(173, 212, 189, 189),
                            border: OutlineInputBorder(),
                            labelText: 'Phone Number'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                            return 'Phone number must have exactly 10 digits';
                          }
                          return null;
                        },
                      ),
                      // SizedBox(height: 16.0),
                      // TextFormField(
                      //   controller: _phoneNumberController,
                      //   keyboardType: TextInputType.phone,
                      //   decoration: InputDecoration(
                      //       filled: true,
                      //       prefixIcon: Icon(
                      //         Icons.phone,
                      //         color: Colors.amber,
                      //       ),
                      //       suffixIcon: Icon(
                      //         Icons.phone,
                      //         color: Colors.amber,
                      //       ),
                      //       fillColor: Color.fromARGB(173, 212, 189, 189),
                      //       border: OutlineInputBorder(),
                      //       labelText: 'Role'),
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'Please enter your phone number';
                      //     } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      //       return 'Phone number must have exactly 10 digits';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                              final User? user = FirebaseAuth.instance.currentUser;
                              if (user != null) {
                                // Create a new document in the 'users' collection with the user's UID as the document ID
                                await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
                                  'name': _nameController.text,
                                  'username': _usernameController.text,
                                  'address': _addressController.text,
                                  'phoneNumber': _phoneNumberController.text,
                                });
                              }
                              await registerWithEmailAndPassword(
                                _emailController.text,
                                _nameController.text,
                                _usernameController.text,
                                _addressController.text,
                                _phoneNumberController.text,
                              );
                            } catch (e) {
                              print('Error creating user: $e');
                            } finally {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 6, 60, 74),
                          padding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 24.0,
                          ),
                        ),
                        child: Text(
                          'Sign Up',
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
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Already have an account? Sign in',
                              style: TextStyle(
                                color: Color.fromARGB(255, 6, 60, 74),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HelpPage(),
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
                          SizedBox(width: 20),
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
