import 'package:escatechonology/Services/authentication.dart';
import 'package:flutter/material.dart';
import 'MainPage.dart';
//import 'Services/DatabaseServices.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
//
  final AuthService _auth = AuthService();

  var _formKey = GlobalKey<FormState>();
//
  String email = "startingE";
  String password = "startingP";
  String error = "";
  TextEditingController emailCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();
//
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.deepPurple[50],
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              logoHeader(context), // This function returns the LOGO

              /// this is displaying form to get login credentials
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: credentialsForm(context),
              ),
              Text(
                error,
                style: TextStyle(
                  fontFamily: "iEvogria",
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),

              /// this is a button to get login after verification
              Container(
                color: Colors.indigo,
                child: RaisedButton(
                  onPressed: () {
                    _loginFunction();
                  },
                  color: Colors.indigo,
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 38),
                  ),
                ),
              ),

              /// this is footter
              footterMessage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget logoHeader(BuildContext context) {
    AssetImage aImg = AssetImage("assets/logo.png");
    Image img = Image(
      image: aImg,
    );
    return Container(
      child: img,
    );
  }

  Widget footterMessage() {
    return Column(
      children: [
        Text("DONT HAVE ACCOUNT?"),
        Text("PLEASE CONTACT"),
        Text("ADMIN AT IT DEPARTMENT"),
        //Text(email),
        //Text(password),
      ],
    );
  }

  Widget credentialsForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email Field
          TextFormField(
            // for login purpose
            controller: this.emailCtl,
            validator: (String v) {
              if (v.isEmpty) {
                return "Must enter Email";
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
                fontSize: 18),
            decoration: InputDecoration(
              hintText: "USERNAME or EMAIL",
              hintStyle: TextStyle(color: Colors.indigo, fontSize: 15),
              filled: true,
              fillColor: Colors.grey[300],
            ),
          ),

          SizedBox(
            height: 20,
          ),

          // Password Field
          TextFormField(
            // for login purpose
            controller: this.passwordCtl,
            validator: (String v) {
              if (v.isEmpty) {
                return "Must enter password";
              }
              return null;
            },
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            style: TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
                fontSize: 18),
            decoration: InputDecoration(
              hintText: "PASSWORD",
              hintStyle: TextStyle(color: Colors.indigo, fontSize: 15),
              filled: true,
              fillColor: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  void _loginFunction() async {
    /// first to validate form, if is, then continue otherwise do nothing at all
    if (_formKey.currentState.validate()) {
      //
      // update the variables
      setState(() {
        this.email = this.emailCtl.text;
        this.password = this.passwordCtl.text;
      });

      /// siging in with email
      dynamic res = await _auth.sigIn(this.email, this.password);
      if (res == null) {
        CircularProgressIndicator(
          backgroundColor: Colors.deepOrange,
        );
        // in case of error
        setState(() {
          this.error = "Could not Login, some error occurred!";
        });
      } else if (res == -1) {
        // in case not a correct registered email
        setState(() {
          this.error = "No user found for that email.";
        });
      } else if (res == -2) {
        // in case not a correct registered password
        setState(() {
          this.error = "Wrong password provided for that user.";
        });
      } else {
        // in case successfully login
        // with correct registerred email and pasword
        setState(() {
          this.error = "";
        });

        //String id = res.user.uid; //displayName

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MainPage("Email(Empolyee ID)", this.email);
            },
          ),
        );
      }
    }
  }
}
