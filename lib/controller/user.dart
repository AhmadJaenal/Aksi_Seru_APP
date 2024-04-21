import 'dart:convert';

import 'package:aksi_seru_app/models/user_model.dart';
import 'package:aksi_seru_app/utils/api.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class UserData extends GetxController {
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token;
  }

  Future<UserModel?> getCurrentUser() async {
    String? token = await getToken();
    final uri = Uri.parse(ApiEndPoints.baseUrl + User.currentUser);
    var headers = {
      'Authorization': '$token',
    };

    try {
      final response = await http.get(uri, headers: headers);
      developer.log(token.toString(), name: 'user token profile');
      developer.log(response.statusCode.toString(), name: 'code response');
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body)['data'];
        developer.log(jsonResponse.toString(), name: 'json response');

        UserModel user = UserModel.fromJson(jsonResponse);
        return user;
      }
    } catch (e) {
      developer.log('Error: $e', name: 'error get user');
    }
  }
}
