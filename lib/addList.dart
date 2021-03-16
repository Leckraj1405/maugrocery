import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maugrocery/common.dart';
import 'package:flutter/cupertino.dart';

class AddListPage extends StatefulWidget {
  @override
  _AddListPageState createState() => _AddListPageState();
}

class _AddListPageState extends State<AddListPage> {
  TextEditingController listnameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Grocery List"),
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
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        "List Name",
                        style: CustomTextStyles.fieldLabelStyle,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextField(
                        controller: listnameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          //labelText: 'item name here',
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
                        onPressed: () {
                          HapticFeedback.mediumImpact();
                          String listname = listnameController.text;
                          print("List Name: $listname");
                        },
                        child: Text(
                          "Create List",
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
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 32),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: TextButton(
                  onPressed: () {
                    HapticFeedback.mediumImpact();
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
