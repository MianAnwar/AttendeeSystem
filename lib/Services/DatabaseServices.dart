import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DatabaseServices {
  final CollectionReference dataCollection =
      FirebaseFirestore.instance.collection("users");

// add user attendence...
  Future addUserAttendence(String email, String scanInfo) async {
    DateFormat f = DateFormat("yyyy-MM-dd");
    String todayDate = f.format(DateTime.now()); //2020-11-1

    CollectionReference attCollection =
        FirebaseFirestore.instance.collection(todayDate);

    var h = (DateTime.now().hour % 12).toString();
    var m = (DateTime.now().minute).toString();
    var cc = (DateTime.now().hour) > 12 ? "pm" : "am";

    return attCollection
        .doc(email)
        .set({
          'Room': scanInfo,
          'Time': h + ":" + m + " " + cc,
        })
        .then((value) => 1) // added
        .catchError((onError) => -1); //failed to add
  }
}
