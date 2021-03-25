import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maugrocery/cardWidget.dart';
import 'package:maugrocery/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:vibration/vibration.dart';

class AddItemPage extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final addItemFormKey = GlobalKey<FormState>();
  String itemname;
  String quantity;
  String notes;
  TextEditingController itemnameController = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();
  TextEditingController notesController = new TextEditingController();
  TextEditingController datepickedController = new TextEditingController();

  List<Widget> cardList = new List();

  // DateTime selectedDate = DateTime.now();
  // _selectDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate, // Refer step 1
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2050),
  //   );
  //   if (picked != null && picked != selectedDate)
  //     setState(
  //       () {
  //         selectedDate = picked;
  //       },
  //     );
  // }

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
          "Enter item name, quantity, date and notes if needed, and press add item");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Add and View Items"),
        backgroundColor: Colors.blueGrey[700],
      ),
      body: Container(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Form(
                  key: addItemFormKey,
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
                          "Item Name",
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
                          validator: (itemname) {
                            if (itemname.isEmpty) {
                              return "Item name cannot be empty";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            HapticFeedback.mediumImpact();
                            itemname = value;
                          },
                          controller: itemnameController,
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
                        child: Text(
                          "Quantity",
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
                          validator: (quantity) {
                            if (quantity.isEmpty) {
                              return "Quantity cannot be empty";
                            } else if (quantity.length > 3) {
                              return "Quantity too high, 3 digits max";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            HapticFeedback.mediumImpact();
                            quantity = value;
                          },
                          controller: quantityController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            //labelText: 'quantity here',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          "Notes",
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
                          validator: (notes) {
                            if (notes.isEmpty) {
                              return "Notes cannot be empty";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            HapticFeedback.mediumImpact();
                            notes = value;
                          },
                          controller: notesController,
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
                            if (addItemFormKey.currentState.validate()) {
                              //code for sign in
                              print('here');
                            }
                            String itemname = itemnameController.text;
                            int quantity = int.parse(quantityController.text);
                            String notes = notesController.text;
                            var uuid = Uuid();
                            String id = uuid.v4();
                            print("id: $id");

                            print("Item Name: $itemname");
                            print("Quantity: $quantity");
                            print("Notes: $notes");
                            print("Date: $displayDate");

                            if (!itemnameController.text.isEmpty) {
                              setState(() {
                                cardList.add(CardWidget(
                                  id: id,
                                  itemName: itemname,
                                  notes: notes,
                                  expiryDate: displayDate,
                                  quantity: quantity,
                                ));
                              });
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
                          },
                          child: Text(
                            "Add Item",
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
