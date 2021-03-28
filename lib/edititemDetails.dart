import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maugrocery/addItem.dart';
import 'package:maugrocery/common.dart';
import 'package:maugrocery/custom_dialog.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_tts/flutter_tts.dart';

class EditItemDetailsPage extends StatefulWidget {
  @override
  _EditItemDetailsPageState createState() => _EditItemDetailsPageState();
}

class _EditItemDetailsPageState extends State<EditItemDetailsPage> {
  TextEditingController itemnameController = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();

  String itemname;
  String quantity;

  final edititemFormKey = GlobalKey<FormState>();
  final FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    Future _speak() async {
      print(await flutterTts.getLanguages);
      await flutterTts.setLanguage("en-GB");
      await flutterTts.setPitch(1);
      await flutterTts.setVolume(100.00);
      await flutterTts.setSpeechRate(0.9);
      await flutterTts
          .speak("Enter item name and quantity. Press update and save button.");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("View & Edit Item Details"),
        backgroundColor: Colors.blueGrey[700],
      ),
      body: Container(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Form(
                  key: edititemFormKey,
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
                          "New Item Name",
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
                          controller: itemnameController,
                          validator: (itemname) {
                            if (itemname.isEmpty) {
                              return "Please enter item name";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            Vibration.vibrate();
                            itemname = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'New Item Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            //labelText: 'password here',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          "New Quantity",
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
                          controller: quantityController,
                          validator: (quantity) {
                            if (quantity.isEmpty) {
                              return "Please enter quantity";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            Vibration.vibrate();
                            quantity = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'New Quantity',
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
                            String itemname = itemnameController.text;
                            print("This is your new item name: $itemname");
                            String quantity = quantityController.text;
                            print("This is your new quantity: $quantity");

                            Vibration.vibrate();
                            if (edititemFormKey.currentState.validate()) {
                              print('here');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddItemPage()));
                              showDialog(
                                context: context,
                                builder: (context) => CustomDialog(
                                  content: Text(
                                    'Item Updated Successfully',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  title: Text('MauGrocery'),
                                  firstColor: Colors.green,
                                  secondColor: Colors.white,
                                  headerIcon: Icon(
                                    Icons.check_circle_outline,
                                    size: 120.0,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Text(
                            "Update & Save",
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
              padding: const EdgeInsets.only(left: 1, bottom: 1),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: TextButton(
                  onPressed: () {
                    _speak();
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