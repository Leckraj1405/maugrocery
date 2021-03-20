import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_validator/form_validator.dart';
import 'package:maugrocery/common.dart';
import 'package:maugrocery/dashboard.dart';
import 'package:vibration/vibration.dart';
import 'custom_dialog.dart';
import 'loading.dart';

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
  bool loading = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  _signIn({String email, String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      setState(() {
        loading = true;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardPage(),
        ),
      );
      // showDialog(
      //   context: context,
      //   builder: (context) => CustomDialog(
      //     content: Text(
      //       'Sign In Successful',
      //       style: TextStyle(
      //         fontWeight: FontWeight.w900,
      //         fontSize: 20.0,
      //       ),
      //     ),
      //     title: Text('MauGrocery'),
      //     firstColor: Colors.green,
      //     secondColor: Colors.white,
      //     headerIcon: Icon(
      //       Icons.check_circle_outline,
      //       size: 120.0,
      //       color: Colors.white,
      //     ),
      //   ),
      // );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          loading = false;
        });

        showDialog(
          context: context,
          builder: (context) => CustomDialog(
            content: Text(
              'User Not Found',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20.0,
              ),
            ),
            title: Text('MauGrocery'),
            firstColor: Colors.red,
            secondColor: Colors.white,
            headerIcon: Icon(
              Icons.error_outline,
              size: 120.0,
              color: Colors.white,
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        setState(() {
          loading = false;
        });
        print('Wrong password provided for that user.');
        // showDialog(
        //     context: context,
        //     child: AlertDialog(
        //       content: Text('wrong password'),
        //       actions: [
        //         FlatButton(
        //           child: Text('Ok'),
        //           onPressed: () => Navigator.pop(context),
        //         ),
        //       ],
        //     ));

        showDialog(
          context: context,
          builder: (context) => CustomDialog(
            content: Text(
              'Incorrect Password',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20.0,
              ),
            ),
            title: Text('MauGrocery'),
            firstColor: Colors.red,
            secondColor: Colors.white,
            headerIcon: Icon(
              Icons.error_outline,
              size: 120.0,
              color: Colors.white,
            ),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("User Sign In"),
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
                              child: Image.asset(
                                  'images/transparentBackground.png'),
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
                                validator: ValidationBuilder()
                                    .email()
                                    .maxLength(50)
                                    .build(),
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
                                    setState(() {
                                      loading = true;
                                    });
                                    print('here');
                                    _signIn(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }

                                  // try {
                                  //   final user = await _auth.signInWithEmailAndPassword(
                                  //       email: email, password: password);
                                  //   if (user != null) {
                                  //     Navigator.pushNamed(context, DashboardPage.id);
                                  //   }
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