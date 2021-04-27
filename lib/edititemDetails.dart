import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maugrocery/common.dart';
import 'package:maugrocery/custom_dialog.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dashboard.dart';

class EditItemDetailsPage extends StatefulWidget {
  DocumentSnapshot docToEdit;

  final String itemName;
  final String listName;
  final String quantity;
  final String notes;
  final String dateCreated;
  final String userId;
  var groceryData = [];

  EditItemDetailsPage({
    this.docToEdit,
    this.itemName,
    this.listName,
    this.quantity,
    this.notes,
    this.dateCreated,
    this.userId,
    this.groceryData,
  });

  @override
  _EditItemDetailsPageState createState() => _EditItemDetailsPageState();
}

class _EditItemDetailsPageState extends State<EditItemDetailsPage> {
  TextEditingController itemnameController = new TextEditingController();
  TextEditingController listnameController = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();
  TextEditingController notesController = new TextEditingController();

  _initialization() {
    setState(() {
      itemnameController.text = widget.itemName;
      listnameController.text = widget.listName;
      quantityController.text = widget.quantity;
      notesController.text = widget.notes;
      displayDate = widget.dateCreated;
    });
  }

  @override
  initState() {
    super.initState();
    _initialization();
  }

  String listname;
  String itemname;
  String quantity;
  String notes;

  final edititemFormKey = GlobalKey<FormState>();
  final FlutterTts flutterTts = FlutterTts();

  DateTime _date = new DateTime.now();
  String displayDate = "No date selected";

  void _selectDate() async {
    Vibration.vibrate();
    final DateTime newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2100, 7),
      helpText: 'Select New Purchase Date',
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
    Future _speak() async {
      await flutterTts.setLanguage("en-GB");
      await flutterTts.setPitch(1);
      await flutterTts.setVolume(1);
      await flutterTts.setSpeechRate(0.8);
      await flutterTts.speak(
          "Enter your desired supermarket name, item name, notes, new date and quantity. Press update and save button.");
    }

    Future _speak1() async {
      await flutterTts.speak("Item updated");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Item Details"),
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
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          "New Store Name",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: 100.0,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          controller: listnameController,
                          validator: (listname) {
                            if (listname.isEmpty) {
                              return "Please enter list name";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            Vibration.vibrate();
                            listname = value;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.storefront_rounded),
                            labelText: 'New Store Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            //labelText: 'password here',
                          ),
                          style: TextStyle(color: Colors.black, fontSize: 22.0),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          "New Item Name",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: 100.0,
                        width: MediaQuery.of(context).size.width * 0.7,
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
                            prefixIcon: Icon(Icons.fastfood_sharp),
                            labelText: 'New Item Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            //labelText: 'password here',
                          ),
                          style: TextStyle(color: Colors.black, fontSize: 22.0),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          "New Quantity",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: 100.0,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          controller: quantityController,
                          validator: (quantity) {
                            if (quantity.isEmpty) {
                              return "Please enter quantity";
                            }
                            return null;
                          },
                          maxLength: 3,
                          onChanged: (value) {
                            Vibration.vibrate();
                            quantity = value;
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.tag),
                            labelText: 'New Quantity',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(color: Colors.black, fontSize: 22.0),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          "New Notes",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: 100.0,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          controller: notesController,
                          validator: (notes) {
                            if (notes.isEmpty) {
                              return "Please enter notes";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            Vibration.vibrate();
                            notes = value;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.notes_sharp),
                            labelText: 'New Notes',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(color: Colors.black, fontSize: 22.0),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: 80.0,
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
                                width: 10.0,
                              ),
                              Icon(
                                Icons.date_range_outlined,
                                color: Colors.black,
                                size: 40,
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                "Add New Date",
                                style: CustomTextStyles.buttonText,
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        "Selected Date: $displayDate",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.70,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFFC6011),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            print(widget.userId);
                            String listname = listnameController.text;
                            print("This is your new store name: $listname");
                            String itemname = itemnameController.text;
                            print("This is your new item name: $itemname");
                            String quantity = quantityController.text;
                            print("This is your new quantity: $quantity");
                            String notes = notesController.text;
                            print("This is your new notes: $notes");
                            print("This is your new date: $displayDate");

                            _speak1();
                            Vibration.vibrate();
                            if (edititemFormKey.currentState.validate()) {
                              print('here');
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(widget.userId)
                                  .update({
                                "grocerylist":
                                    FieldValue.arrayRemove(widget.groceryData)
                              });
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(widget.userId)
                                  .update({
                                "grocerylist": FieldValue.arrayUnion([
                                  {
                                    "listname": "${listnameController.text}",
                                    "datecreated": "$displayDate",
                                    "itemname": "${itemnameController.text}",
                                    "quantity": "${quantityController.text}",
                                    "notes": "${notesController.text}"
                                  }
                                ])
                              });

                              listnameController.clear();
                              itemnameController.clear();
                              quantityController.clear();
                              notesController.clear();
                              displayDate = "";

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DashboardPage()));
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
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15.0,
                              ),
                              Icon(
                                Icons.edit_outlined,
                                color: Colors.black,
                                size: 40,
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                "Update Item",
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
