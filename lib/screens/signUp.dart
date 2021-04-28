import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:form_validator/form_validator.dart';
import 'package:vibration/vibration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maugrocery/screens/dashboard.dart';
import 'package:maugrocery/screens/sign_in.dart';
import 'package:maugrocery/styles/common.dart';
import 'package:maugrocery/styles/loading.dart';
import 'package:maugrocery/styles/custom_dialog.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isHiddenPassword = true;
  String email;
  String password;
  String confirmpassword;
  bool loading = false;

  final _auth = FirebaseAuth.instance;
  final signUpFormKey = GlobalKey<FormState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  _register({String email, String password}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      FirebaseAuth _auth = FirebaseAuth.instance;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser.uid)
          .set({
        "email": email,
        "grocerylist": [
          {
            "listname": "sample",
            "datecreated": "2020-10-10",
            "itemname": "sample",
            "quantity": "111",
            "notes": "sample"
          }
        ]
      });

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage()),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        setState(() {
          loading = false;
        });
        showDialog(
          context: context,
          builder: (context) => CustomDialog(
            content: Text(
              'Password too weak!',
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
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        setState(() {
          loading = false;
        });
        showDialog(
          context: context,
          builder: (context) => CustomDialog(
            content: Text(
              'Email Already Exists',
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
    } catch (e) {
      print(e);
    }
  }

  final FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    Future _speak() async {
      await flutterTts.setLanguage("en-GB");
      await flutterTts.setPitch(1);
      await flutterTts.setVolume(1);
      await flutterTts.setSpeechRate(0.8);
      await flutterTts.speak(
          "Enter your email and password and press register to create your account and tap on the bottom right section of your screen if you already an account to sign in.");
    }

    Future _speak1() async {
      await flutterTts.speak("User registration in process.");
    }

    Future _speak2() async {
      await flutterTts.speak("Going to Sign In page.");
    }

    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("User Registration"),
              backgroundColor: Colors.blueGrey[700],
            ),
            body: Container(
              child: Stack(
                children: [
                  Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: signUpFormKey,
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
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                "Email Address",
                                style: CustomTextStyles.fieldLabelStyle,
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              height: 50.0,
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: TextFormField(
                                controller: emailController,
                                validator: ValidationBuilder()
                                    .email()
                                    .maxLength(50)
                                    .build(),
                                onChanged: (value) {
                                  Vibration.vibrate();
                                  email = value;
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email_sharp),
                                  labelText: 'Email',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 22.0),
                              ),
                            ),
                            SizedBox(
                              height: 35.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
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
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: TextFormField(
                                controller: passwordController,
                                validator: (password) {
                                  if (password.isEmpty) {
                                    return "Password cannot be empty";
                                  } else if (password.length < 6) {
                                    return "Password too short";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  Vibration.vibrate();
                                  password = value;
                                },
                                obscureText: isHiddenPassword,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.security_sharp),
                                  suffixIcon: InkWell(
                                      onTap: _togglePasswordView,
                                      child: Icon(Icons.visibility)),
                                  labelText: 'Min 6 Characters',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 22.0),
                              ),
                            ),
                            SizedBox(
                              height: 35.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                "Confirm Password",
                                style: CustomTextStyles.fieldLabelStyle,
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              height: 50.0,
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: TextFormField(
                                validator: (confirmpassword) {
                                  if (confirmpassword.isEmpty) {
                                    return "Please fill";
                                  } else if (confirmpassword != password) {
                                    return "Password mismatch";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  Vibration.vibrate();
                                  confirmpassword = value;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.security_sharp),
                                  labelText: 'Confirm Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 22.0),
                              ),
                            ),
                            SizedBox(
                              height: 35.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFFC6011),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  _speak1();
                                  Vibration.vibrate();
                                  if (signUpFormKey.currentState.validate()) {
                                    print(
                                        '------------------------------------------');
                                    print('validated');
                                    print(
                                        '------------------------------------------');
                                    setState(() {
                                      loading = true;
                                    });
                                    _register(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 40.0,
                                    ),
                                    Icon(
                                      Icons.app_registration,
                                      color: Colors.black,
                                      size: 45,
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Text(
                                      "Register",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 35.0),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                  ],
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
                    padding: const EdgeInsets.only(left: 1, bottom: 1),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: TextButton(
                        onPressed: () {
                          _speak();
                          Vibration.vibrate();
                          print("voice synthesis running");
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
                          child: Center(
                            child: Icon(
                              Icons.mic_outlined,
                              color: Colors.black,
                              size: 45,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 1, bottom: 1),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          _speak2();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInPage(),
                            ),
                          );
                          Vibration.vibrate();
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
                          child: Center(
                            child: Icon(
                              Icons.login_outlined,
                              color: Colors.black,
                              size: 40,
                            ),
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

  void _togglePasswordView() {
    if (isHiddenPassword == true) {
      isHiddenPassword = false;
    } else {
      isHiddenPassword = true;
    }
    setState(() {});
  }
}
