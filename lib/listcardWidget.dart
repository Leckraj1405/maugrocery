import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:maugrocery/edititemDetails.dart';
import 'package:vibration/vibration.dart';

class CardWidget extends StatefulWidget {
  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  final FlutterTts flutterTts = FlutterTts();
  String userid;

  Future getCurrentUser() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final uid = _auth.currentUser.uid;
    print(uid);
    return uid.toString();
  }

  Future _speak1() async {
    await flutterTts.speak("Going to Edit Item page.");
  }

  Future _speak2() async {
    await flutterTts.speak("Item is being deleted.");
  }

  void initState() {
    getCurrentUser().then((id) {
      print('USER ID: ${id.toString()}');
      setState(() {
        userid = id.toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("users").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          height: 315,
          width: 370,
          child: ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              if (userid == snapshot.data.docs[index].id) {
                final List<dynamic> groceryList =
                    snapshot.data.docs[index]['grocerylist'];

                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: groceryList.length,
                    itemBuilder: (context, index) => Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Color(0xFFFC6011),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 5.0, top: 10.0, bottom: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Store: ${groceryList[index]['listname']}',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 1.0,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Item: ${groceryList[index]['itemname']}',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Quantity: ${groceryList[index]['quantity']}',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.7,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Purchase Date: ${groceryList[index]['datecreated']}',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.0,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Notes: ${groceryList[index]['notes']}',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  // Expanded(
                                  //   child: Text(
                                  //       '${groceryList[index]['listname']}'),
                                  // ),
                                  // Expanded(
                                  //     child: IconButton(
                                  //   icon: Icon(Icons.delete),
                                  // )),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey[700],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        _speak1();
                                        Vibration.vibrate();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditItemDetailsPage()));
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.edit_outlined,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 15.0,
                                          ),
                                          Text(
                                            "Edit Details",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0),
                                          ),
                                          SizedBox(
                                            width: 15.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey[700],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        // FirebaseAuth _auth =
                                        //     FirebaseAuth.instance;
                                        // final uid = _auth.currentUser.uid;
                                        // FirebaseFirestore.instance
                                        //     .collection("users")
                                        //     .doc(uid)
                                        //     .delete();
                                        _speak2();
                                        Vibration.vibrate();
                                        //call method to delete from database
                                        //eg. deleteCard(widget.id);
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 15.0,
                                          ),
                                          Text(
                                            "Delete",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0),
                                          ),
                                          SizedBox(
                                            width: 15.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )));
              }
              return Text('');
            },
          ),
        );
      },
    );
  }
}
