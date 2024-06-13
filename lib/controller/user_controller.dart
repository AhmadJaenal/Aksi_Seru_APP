import 'package:aksi_seru_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class UserData extends GetxController {
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token;
  }

  Stream<UserModel?> getCurrentUser() async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");

    if (email == null) {
      yield null;
      return;
    }

    yield* FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return null;
      }

      var userData = snapshot.docs.first.data();
      return UserModel.fromJson(userData);
    }).handleError((e) {
      developer.log(e.toString(), name: 'catch error');
      return null;
    });
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getUserByEmail(
      {String? email}) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get();
    return querySnapshot;
  }

  static Future getRandomUser() async {
    return await FirebaseFirestore.instance.collection("users").limit(10).get();
  }
}
