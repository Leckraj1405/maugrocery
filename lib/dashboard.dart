import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maugrocery/edituserdetails.dart';
import 'package:maugrocery/listcardWidget.dart';
import 'package:maugrocery/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:vibration/vibration.dart';
import 'custom_dialog.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DashboardPage extends StatefulWidget {
  static const String id = 'DashboardPage';
  // final String listname;
  // final String datecreated;
  //
  // DashboardPage(this.listname, this.datecreated);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  TextEditingController listnameController = new TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        final loggedInUser = user;
        print(loggedInUser.email);
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
      helpText: 'Select a date',
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

  @override
  Widget build(BuildContext context) {
    // CollectionReference grocerylists =
    //     FirebaseFirestore.instance.collection('grocerylists');
    // Future<void> DashboardPage() {
    //   // Call the user's CollectionReference to add a new user
    //   return grocerylists
    //       .add({
    //         'listname': listname, // John Doe
    //         'datecreated': datecreated, // Stokes and Sons
    //       })
    //       .then((value) => print("User Added"))
    //       .catchError((error) => print("Failed to add user: $error"));
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard - Grocery Lists"),
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
                    Column(
                      children: cardList,
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
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 80.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFFC6011),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: TextButton(
                        onPressed: _selectDate,
                        child: Text(
                          "Select Date",
                          style: CustomTextStyles.buttonText,
                        ),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    Text(
                      "Selected Date: $displayDate",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
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
                          Vibration.vibrate();
                          String listname = listnameController.text;
                          var uuid = Uuid();
                          String id = uuid.v4();
                          print("id: $id");

                          print("List Name: $listname");
                          print("Date Created: $displayDate");

                          if (!listnameController.text.isEmpty) {
                            setState(() {
                              Vibration.vibrate();
                              cardList.add(CardWidget(
                                id: id,
                                listName: listname,
                                creationDate: displayDate,
                              ));
                            });
                          }
                        }

                        //add the data to database

                        /*
                            retrieve list from database
                            put into array
                            for loop in array
                            eg. for(int i = 0; i < array.length; i++)
                            {
                            cardList.add(CardWidget(
                              itemName: array[i].itemname,
                              notes: array[i].notes,
                              expiryDate: array[i].displayDate,
                              quantity: array[i].quantity,
                            ));
                            }
                            */
                        ,
                        child: Text(
                          "Add List",
                          style: CustomTextStyles.buttonText,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 100.0,
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
                              builder: (context) => EditUserDetailsPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Edit User Account",
                          style: CustomTextStyles.buttonText,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFFC6011),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () async {
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
                        child: Text(
                          "Sign Out",
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
