import 'package:escatechonology/ErrorPage.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'Services/DatabaseServices.dart';
import 'SuccessPage.dart';

class MainPage extends StatefulWidget {
  MainPage(String username, String email) {
    MainPage.username = username;
    MainPage.email = email;
  }

  static String email;
  static String username;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String scanError = "";
  String scanInfo = "";

  final DatabaseServices _dServce = DatabaseServices();

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
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.indigoAccent,
              fontWeight: FontWeight.w700,
              fontSize: 37),
        ),
        // to see the value of qr code
        showErrorMsg(),
      ],
    );
  }

  Widget showErrorMsg() {
    return Padding(
      padding: const EdgeInsets.only(top: 38.0),
      child: Text(
        this.scanError,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: (this.scanError != "meeting" && this.scanError != "conference")
              ? Colors.red[200]
              : Colors.green,
          fontWeight: FontWeight.w700,
          fontSize: 25,
        ),
      ),
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
          this.scanInfo = barcode;
        });
        proceedToSubmitToFB();
      }
    }
  }

  void proceedToSubmitToFB() async {
    ///////////////////////////////////////
    // code here to put data to firebase //

    if (scanInfo.toLowerCase() == "meeting" ||
        scanInfo.toLowerCase() == "conference") {
      dynamic v =
          await _dServce.addUserAttendence(MainPage.email, this.scanInfo);
      CircularProgressIndicator();
      if (v == null || v == -1) {
        setState(() {
          this.scanError =
              "\n\nystem could not submit your attendence! \nOR\n\t You have already Submitted your Attendence. \nCheck Internet Connectivity! \nContact Devleoper";
        });
      } else if (v == 1) {
        setState(() {
          this.scanError = scanInfo;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return SuccessPage();
            },
          ),
        );
      }
    } else {
      setState(() {
        this.scanError = "\n\n Invalid QR Code!";
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ErrorPage();
          },
        ),
      );
    }
  }

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
}
