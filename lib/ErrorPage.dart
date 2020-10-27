import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepOrange,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                logoHeader(context), // This function returns the LOGO
                showFormattedMessage("Something Wrong \n E R R O R", 40.9),
                showButtonTogoHome(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget logoHeader(BuildContext context) {
    AssetImage aImg = AssetImage("assets/logo.png");
    Image img = Image(image: aImg);
    return Container(child: img);
  }

  Widget showFormattedMessage(String msg, double size) {
    return Container(
      child: Text(
        msg,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: "iEvogria",
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
            fontSize: size),
      ),
    );
  }

  Widget showButtonTogoHome() {
    return Container(
      color: Colors.indigo,
      child: RaisedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        color: Colors.indigo,
        child: Text(
          "HOME",
          style: TextStyle(
              fontFamily: "Evogria",
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 38),
        ),
      ),
    );
  }
}
