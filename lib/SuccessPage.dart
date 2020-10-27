import 'package:flutter/material.dart';
import 'MainPage.dart';

class SuccessPage extends StatefulWidget {
  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple[100],
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                logoHeader(context), // This function returns the LOGO
                showFormattedMessage("SUCESSFULLY \n L O G I N", 40.9),
                showCredentials(),
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

  Widget showCredentials() {
    return Column(
      children: [
        Text(
          MainPage.username,
          style: TextStyle(
              // fontFamily: "Evogria",
              color: Colors.indigoAccent,
              fontWeight: FontWeight.normal,
              fontSize: 28),
        ),
        Text(
          MainPage.email,
          style: TextStyle(
              color: Colors.indigoAccent,
              fontWeight: FontWeight.w700,
              fontSize: 25),
        ),
      ],
    );
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
