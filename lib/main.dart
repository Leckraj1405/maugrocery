import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maugrocery/help.dart';
import 'package:maugrocery/signIn.dart';
import 'package:maugrocery/signUp.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MauGrocery());
}

class MauGrocery extends StatefulWidget {
  @override
  _MauGroceryState createState() => _MauGroceryState();
}

class _MauGroceryState extends State<MauGrocery> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final FlutterTts flutterTts = FlutterTts();
  @override
  Widget build(BuildContext context) {
    Future _speak() async {
      //print(await flutterTts.getLanguages);
      await flutterTts.setLanguage("en-GB");
      await flutterTts.setPitch(1);
      await flutterTts.setVolume(1);
      await flutterTts.setSpeechRate(0.8);
      await flutterTts.speak(
          "Welcome to MauGrocery, to login, press the upper section of the screen, and to register, press the lower area of the screen. Tap on the bottom right of your screen to access the information page.");
    }

    Future _speak1() async {
      await flutterTts.speak("Going to Sign In page.");
    }

    Future _speak2() async {
      await flutterTts.speak("Going to Registration Page");
    }

    Future _speak3() async {
      await flutterTts.speak("Going to Information Page");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("MauGrocery - Welcome"),
        backgroundColor: Colors.blueGrey[700],
      ),
      body: Container(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
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
                      width: 300.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                          color: Color(0xFFFC6011),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TextButton(
                        onPressed: () {
                          _speak1();
                          Vibration.vibrate();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInPage()));
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
                      height: 60.0,
                    ),
                    Container(
                      width: 300.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFFC6011),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          _speak2();
                          Vibration.vibrate();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 40.0,
                            ),
                            Icon(
                              Icons.app_registration,
                              color: Colors.black,
                              size: 50,
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
                      height: 30.0,
                    ),
                  ],
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
                    _speak3();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HelpPage()));
                    Vibration.vibrate();
                    print("redirecting to help page");
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
                        Icons.info_outline_rounded,
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
}
