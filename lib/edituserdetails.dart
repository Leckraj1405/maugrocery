import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maugrocery/common.dart';
import 'package:maugrocery/custom_dialog.dart';
import 'package:vibration/vibration.dart';

class EditUserDetailsPage extends StatefulWidget {
  @override
  _EditUserDetailsPageState createState() => _EditUserDetailsPageState();
}

class _EditUserDetailsPageState extends State<EditUserDetailsPage> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  String username;
  String email;
  String password;
  String confirmpassword;

  final edituserDetailsFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit User Details"),
        backgroundColor: Colors.blueGrey[700],
      ),
      body: Container(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Form(
                  key: edituserDetailsFormKey,
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
                          "New Username",
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
                          validator: (username) {
                            if (username.isEmpty) {
                              return "Username cannot be empty";
                            } else if (username.length < 3) {
                              return "Username too short";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            HapticFeedback.mediumImpact();
                            username = value;
                          },
                          controller: usernameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            //labelText: 'username here',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          "New Email Address",
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
                          validator: (email) {
                            if (email.isEmpty) {
                              return "Email cannot be empty";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            HapticFeedback.mediumImpact();
                            email = value;
                          },
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            //labelText: 'email address here',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          "New Password",
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
                          validator: (password) {
                            if (password.isEmpty) {
                              return "Password cannot be empty";
                            } else if (password.length < 5) {
                              return "Password too short";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            HapticFeedback.mediumImpact();
                            password = value;
                          },
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
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
                          "Confirm Password",
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
                          validator: (confirmpassword) {
                            if (confirmpassword.isEmpty) {
                              return "Please confirm password";
                            } else if (confirmpassword != password) {
                              return "Password mismatch";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            Vibration.vibrate();
                            confirmpassword = value;
                          },
                          obscureText: true,
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
                            showDialog(
                              context: context,
                              builder: (context) => CustomDialog(
                                content: Text(
                                  'Update Successful',
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

                            Vibration.vibrate();
                            if (edituserDetailsFormKey.currentState
                                .validate()) {
                              //code for sign up
                              print('here');
                            }
                            String username = usernameController.text;
                            String email = emailController.text;
                            String password = passwordController.text;

                            print("This is your new username: $username");
                            print("This is your new email address: $email");
                            print("This is your new password: $password");
                          },
                          child: Text(
                            "Update Details",
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
