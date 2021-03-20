import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class CardWidget extends StatefulWidget {
  final String id, listName, creationDate;

  const CardWidget({this.id, this.listName, this.creationDate});

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFFC6011),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          height: 190.0,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 25.0, right: 25.0, top: 20.0, bottom: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.listName,
                  style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Text(
                      "Date Created: ${widget.creationDate}",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Container(
                      color: Colors.blueGrey[700],
                      child: TextButton(
                        onPressed: () {
                          Vibration.vibrate();
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.preview_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "View List",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25.0,
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
                              width: 10.0,
                            ),
                            Text(
                              "Delete",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 25.0,
        ),
      ],
    );
  }
}