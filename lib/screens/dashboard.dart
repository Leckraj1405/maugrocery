import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:uuid/uuid.dart';
import 'package:vibration/vibration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maugrocery/styles/listcardWidget.dart';
import 'package:maugrocery/styles/common.dart';
import 'package:maugrocery/styles/custom_dialog.dart';
import 'package:maugrocery/main.dart';

class DashboardPage extends StatefulWidget {
  static const String id = 'DashboardPage';

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  TextEditingController listnameController = new TextEditingController();
  TextEditingController itemnameController = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();
  TextEditingController notesController = new TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final dashboardFormKey = GlobalKey<FormState>();

  String listname;
  String itemname;
  String quantity;
  String notes;

  _getCurrentUser() {
    if (_auth.currentUser != null) {
      print('------------------------------------------');
      print(' uid : ${_auth.currentUser.uid}');
      print('email : ${_auth.currentUser.email}');
      print('------------------------------------------');
    }
  }

  @override
  void initState() {
    _getCurrentUser();
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        final loggedInUser = user;
        print('------------------------------------------');
        print(loggedInUser.email);
        print('------------------------------------------');
      }
    } catch (e) {
      print(e);
    }
  }

  List<Widget> cardList = new List();

  DateTime _date = new DateTime.now();
  String displayDate = "No date selected";

  void _selectDate() async {
    Vibration.vibrate();
    final DateTime newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2100, 7),
      helpText: 'Select Purchase Date',
    );
    if (newDate != null) {
      displayDate = newDate.toString();
      displayDate = displayDate[0] +
          displayDate[1] +
          displayDate[2] +
          displayDate[3] +
          displayDate[4] +
          displayDate[5] +
          displayDate[6] +
          displayDate[7] +
          displayDate[8] +
          displayDate[9];
      setState(() {
        _date = newDate;
      });
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
          "Enter your item details in the text field provided, such as the supermarket name, item name, its quantity, the purchase date and add some notes as well. Hit add item to add the item to your list, and find the sign out options below.");
    }

    Future _speak1() async {
      await flutterTts.speak("Item added.");
    }

    Future _speak2() async {
      await flutterTts.speak("Signing out.");
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Home - MauGrocery"),
        backgroundColor: Colors.blueGrey[700],
      ),
      body: Container(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Form(
                  key: dashboardFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset('images/transparentBackground.png'),
                      ),
                      Text(
                        "Currently logged in as: ${_auth.currentUser.email}",
                        style: TextStyle(
                          color: Colors.blueGrey[700],
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      CardWidget(),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          "Enter Grocery Details",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        height: 100.0,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: TextFormField(
                          validator: (listname) {
                            if (listname.isEmpty) {
                              return "List name cannot be empty";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            Vibration.vibrate();
                            listname = value;
                          },
                          controller: listnameController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.storefront_rounded),
                            labelText: 'Store Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(color: Colors.black, fontSize: 22.0),
                        ),
                      ),
                      SizedBox(
                        height: 1.0,
                      ),
                      Container(
                        height: 100.0,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: TextFormField(
                          validator: (itemname) {
                            if (itemname.isEmpty) {
                              return "Item name cannot be empty";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            Vibration.vibrate();
                            itemname = value;
                          },
                          controller: itemnameController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.fastfood_sharp),
                            labelText: 'Item Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(color: Colors.black, fontSize: 22.0),
                        ),
                      ),
                      SizedBox(
                        height: 1.0,
                      ),
                      Container(
                        height: 100.0,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: TextFormField(
                          validator: (quantity) {
                            if (quantity.isEmpty) {
                              return "Quantity cannot be empty";
                            } else if (quantity.length > 3) {
                              return "Quantity too high, 3 digits max";
                            }
                            return null;
                          },
                          maxLength: 3,
                          onChanged: (value) {
                            Vibration.vibrate();
                            quantity = value;
                          },
                          controller: quantityController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.tag),
                            labelText: 'Quantity',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(color: Colors.black, fontSize: 22.0),
                        ),
                      ),
                      SizedBox(
                        height: 1.0,
                      ),
                      Container(
                        height: 100.0,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: TextFormField(
                          validator: (notes) {
                            if (notes.isEmpty) {
                              return "Notes cannot be empty";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            Vibration.vibrate();
                            notes = value;
                          },
                          controller: notesController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.notes_sharp),
                            labelText: 'Notes',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(color: Colors.black, fontSize: 22.0),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.70,
                        height: 90.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFFC6011),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: TextButton(
                          onPressed: _selectDate,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15.0,
                              ),
                              Icon(
                                Icons.date_range_outlined,
                                color: Colors.black,
                                size: 40,
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text(
                                "Select Date",
                                style: CustomTextStyles.buttonText,
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 22.0),
                      Text(
                        "Purchase Date: $displayDate",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
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
                            _speak1();
                            Vibration.vibrate();
                            if (!dashboardFormKey.currentState.validate()) {}
                            String listname = listnameController.text;
                            String itemname = itemnameController.text;
                            String quantity = quantityController.text;
                            String notes = notesController.text;
                            var uuid = Uuid();
                            String id = uuid.v4();
                            print('------------------------------------------');
                            print("id: $id");
                            print("Store Name: $listname");
                            print("Item Name: $itemname");
                            print("Quantity: $quantity");
                            print("Notes: $notes");
                            print("Date to Purchase: $displayDate");
                            print('------------------------------------------');

                            if (!listnameController.text.isEmpty) {
                              FirebaseAuth _auth = FirebaseAuth.instance;
                              final uid = _auth.currentUser.uid;
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(uid)
                                  .update({
                                "grocerylist": FieldValue.arrayUnion([
                                  {
                                    "listname": "$listname",
                                    "datecreated": "$displayDate",
                                    "itemname": "$itemname",
                                    "quantity": "$quantity",
                                    "notes": "$notes"
                                  }
                                ])
                              });
                              itemnameController.clear();
                              quantityController.clear();
                              notesController.clear();
                              listnameController.clear();
                              displayDate = "";
                            }
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15.0,
                              ),
                              Icon(
                                Icons.add_box_outlined,
                                color: Colors.black,
                                size: 45,
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                "Add Item",
                                style: CustomTextStyles.buttonText,
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.60,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFFC6011),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            _speak2();
                            Vibration.vibrate(duration: 1000);
                            await FirebaseAuth.instance.signOut();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MauGrocery(),
                              ),
                            );
                            showDialog(
                              context: context,
                              builder: (context) => CustomDialog(
                                content: Text(
                                  'Sign Out Successful',
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
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15.0,
                              ),
                              Icon(
                                Icons.logout,
                                color: Colors.black,
                                size: 45,
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                "Sign Out",
                                style: CustomTextStyles.buttonText,
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
            )
          ],
        ),
      ),
    );
  }
}
