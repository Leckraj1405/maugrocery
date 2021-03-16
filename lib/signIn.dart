import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maugrocery/addItem.dart';
import 'package:maugrocery/common.dart';
import 'package:maugrocery/dashboard.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vibration/vibration.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final signInFormKey = GlobalKey<FormState>();
  String email;
  String password;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  // final _auth = FirebaseAuth.instance;

  FirebaseAuth auth = FirebaseAuth.instance;
  //FirebaseUser loggedInUser;

  _signIn({String email, String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardPage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
            context: context,
            child: AlertDialog(
              content: Text('User not found'),
              actions: [
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ));
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        showDialog(
            context: context,
            child: AlertDialog(
              content: Text('wrong password'),
              actions: [
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ));
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        backgroundColor: Colors.blueGrey[700],
      ),
      body: Container(
        // key: _form,
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Form(
                  key: signInFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset('images/transparentBackground.png'),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          "Email",
                          style: CustomTextStyles.fieldLabelStyle,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: TextFormField(
                          controller: emailController,
                          validator: (email) {
                            if (email.isEmpty) {
                              return "Email cannot be empty";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            HapticFeedback.mediumImpact();
                            email = value;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            //labelText: 'username here',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          "Password",
                          style: CustomTextStyles.fieldLabelStyle,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: TextFormField(
                          controller: passwordController,
                          validator: (password) {
                            if (password.isEmpty) {
                              return "Password cannot be empty";
                            } else if (password.length < 5) {
                              return "Password too short";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            HapticFeedback.mediumImpact();
                            password = value;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFFC6011),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            Vibration.vibrate();
                            if (signInFormKey.currentState.validate()) {
                              //code for sign in
                              print('here');
                            }
                            _signIn(
                                email: emailController.text,
                                password: passwordController.text);
                            // try {
                            //   final user = await _auth.signInWithEmailAndPassword(
                            //       email: email, password: password);
                            //
                            //   if (user != null) {
                            //     Navigator.pushNamed(context, DashboardPage.id);
                            //   }
                            //
                            //   // String email = emailController.text;
                            //   // String password = passwordController.text;
                            //   //
                            //   // print("This is your email: $email");
                            //   // print("This is your password: $password");

                            //
                            // } catch (e) {
                            //   print(e);
                            // }
                          },
                          child: Text(
                            "Sign in",
                            style: CustomTextStyles.buttonText,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 32),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: TextButton(
                  onPressed: () {
                    Vibration.vibrate();
                    print("MIC ON");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFC6011),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    width: 75.0,
                    height: 75.0,
                    //color: Colors.black,
                    child: Center(
                      child: Icon(FontAwesomeIcons.microphone),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
