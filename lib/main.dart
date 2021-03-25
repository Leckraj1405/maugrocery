import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maugrocery/common.dart';
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
      print(await flutterTts.getLanguages);
      await flutterTts.setLanguage("en-GB");
      await flutterTts.setPitch(1);
      await flutterTts.setVolume(100.00);
      await flutterTts.setSpeechRate(0.9);
      await flutterTts.speak(
          "Welcome to MauGrocery, to login, press the upper section of the screen, and to register, press the lower area of the screen");
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
                      width: 250.0,
                      height: 125.0,
                      decoration: BoxDecoration(
                          color: Color(0xFFFC6011),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TextButton(
                        onPressed: () {
                          Vibration.vibrate();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInPage()));
                        },
                        child: Text(
                          "Sign In",
                          style: CustomTextStyles.buttonText,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Container(
                      width: 250.0,
                      height: 125.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFFC6011),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Vibration.vibrate();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Register",
                          style: CustomTextStyles.buttonText,
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
