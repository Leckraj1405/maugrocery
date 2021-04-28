import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:form_validator/form_validator.dart';
import 'package:vibration/vibration.dart';
import 'package:maugrocery/screens/dashboard.dart';
import 'package:maugrocery/screens/signUp.dart';
import 'package:maugrocery/styles/common.dart';
import 'package:maugrocery/styles/loading.dart';
import 'package:maugrocery/styles/custom_dialog.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isHiddenPassword = true;
  final signInFormKey = GlobalKey<FormState>();

  String email;
  String password;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool loading = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  _signIn({String email, String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      setState(() {
        loading = false;
      });

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage()),
          (route) => false);
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

  final FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    Future _speak() async {
      await flutterTts.setLanguage("en-GB");
      await flutterTts.setPitch(1);
      await flutterTts.setVolume(1);
      await flutterTts.setSpeechRate(0.8);
      await flutterTts.speak(
          "Enter your email and password to sign in, and tap on the bottom right section of your screen if you need to create an account.");
    }

    Future _speak1() async {
      await flutterTts.speak("User sign in in process.");
    }

    Future _speak2() async {
      await flutterTts.speak("Going to Registration page.");
    }

    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("User Sign In"),
              backgroundColor: Colors.blueGrey[700],
            ),
            body: Container(
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
                              width: MediaQuery.of(context).size.width * 0.7,
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
                                  } else if (password.length < 5) {
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
                                  labelText: 'Password',
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
                              height: 125.0,
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
                                  if (signInFormKey.currentState.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    print(
                                        '------------------------------------------');
                                    _signIn(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 40.0,
                                    ),
                                    Icon(
                                      Icons.login_outlined,
                                      color: Colors.black,
                                      size: 50,
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Text(
                                      "Sign In",
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
                          //color: Colors.black,
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
                              builder: (context) => SignUpPage(),
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
                              Icons.app_registration,
                              color: Colors.black,
                              size: 45,
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
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }
}
