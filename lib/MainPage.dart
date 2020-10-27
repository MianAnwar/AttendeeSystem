import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'SuccessPage.dart';

class MainPage extends StatefulWidget {
  ////
  static String username;
  static String email;
  MainPage(String username, String email) {
    MainPage.username = username;
    MainPage.email = email;
  }

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String info = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //  backgroundColor: Colors.deepPurple[50],
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              logoHeader(context), // This function returns the LOGO
              showFormattedMessage("W E L C O M E", 40.9),
              showCredentials(),
              showFormattedMessage("SCAN TO LOG ATTENDENCE", 25),
              showButtonToScan(),
            ],
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
        // to see the value of qr code
        Text(
          this.info,
          style: TextStyle(
              color: Colors.cyan, fontWeight: FontWeight.w700, fontSize: 20),
        ),
      ],
    );
  }

  Widget showFormattedMessage(String msg, double size) {
    return Container(
      child: Text(
        msg,
        style: TextStyle(
            fontFamily: "iEvogria",
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
            fontSize: size),
      ),
    );
  }

  Widget showButtonToScan() {
    return Container(
      color: Colors.indigo,
      child: RaisedButton(
        onPressed: () async {
          _continueToScan();
        },
        color: Colors.indigo,
        child: Text(
          "SCAN",
          style: TextStyle(
              fontFamily: "iEvogria",
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 38),
        ),
      ),
    );
  }

  void _continueToScan() async {
    bool correctCredentials = true;
    if (correctCredentials) {
      String barcode = "";
      barcode = await scanner.scan();

      if (barcode != "") {
        setState(() {
          this.info = barcode;
        });
        proceedToSubmitToFB();
      }
    }
  }

  void proceedToSubmitToFB() {
    ///////////////////////////////////////
    // code here to put data to firebase //
    ///////////////////////////////////////
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return SuccessPage();
        },
      ),
    );
  }
}
