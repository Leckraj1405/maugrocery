import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future _speak() async {
      await flutterTts.setLanguage("en-GB");
      await flutterTts.setPitch(1);
      await flutterTts.setVolume(1);
      await flutterTts.setSpeechRate(0.8);
      await flutterTts.speak(
          "MauGrocery is a grocery inventory planner. Create your item card by entering the store name, item name, and its related details. MauGrocery is suitable for people with visual impairments, and voice synthesisers help user to navigate the application.");
    }

    // the help page shows information about the purpose of MauGrocery
    return Scaffold(
      appBar: AppBar(
        title: Text("App Information"),
        backgroundColor: Colors.blueGrey[700],
      ),
      body: Container(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset('images/transparentBackground.png'),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        // width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          "What is MauGrocery?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35.0,
                              color: Colors.blueGrey[700]),
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(
                          "MauGrocery is a grocery inventory planner. Create your item card by entering the store name, item name, and its related details.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22.0, color: Colors.blueGrey[700]),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(
                          "MauGrocery is suitable for people with visual impairments, and voice synthesisers help user to navigate the application.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22.0, color: Colors.blueGrey[700]),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(
                          "Developer contact: LL675@live.mdx.ac.uk",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                              color: Colors.blueGrey[700]),
                        ),
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
                    HapticFeedback.mediumImpact();
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
            )
          ],
        ),
      ),
    );
  }
}
