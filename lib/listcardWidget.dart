import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maugrocery/edititemDetails.dart';
import 'package:vibration/vibration.dart';

class CardWidget extends StatefulWidget {
  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  String userid;

  Future getCurrentUser() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final uid = _auth.currentUser.uid;
    print(uid);
    return uid.toString();
  }

  @override
  void initState() {
    getCurrentUser().then((id) {
      print('xxxx ${id.toString()}');
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
          height: 350,
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
                              left: 25.0, right: 25.0, top: 20.0, bottom: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${groceryList[index]['listname']}',
                                style: TextStyle(
                                    fontSize: 32.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
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
                                  // ))
                                  Container(
                                    color: Colors.blueGrey[700],
                                    child: TextButton(
                                      onPressed: () {
                                        Vibration.vibrate();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditItemDetailsPage(),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.edit,
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
                                    color: Colors.blueGrey[700],
                                    child: TextButton(
                                      onPressed: () {
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
