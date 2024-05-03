import 'dart:convert';
import 'dart:io';

import 'package:aksi_seru_app/models/user_model.dart';
import 'package:aksi_seru_app/utils/api.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:dio/dio.dart' as dio;
import 'package:path_provider/path_provider.dart';

class UserData extends GetxController {
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token;
  }

  Future<UserModel?> getCurrentUser() async {
    String? token = await getToken();
    // developer.log(token.toString(), name: 'token user profile');
    final uri = Uri.parse(ApiEndPoints.baseUrl + UserEndPoints.currentUser);
    var headers = {
      'X-Authorization': '$token',
    };

    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body)['data'];
        // developer.log(jsonResponse.toString(), name: 'json response');

        UserModel user = UserModel.fromJson(jsonResponse);
        return user;
      } else if (response.statusCode == 401) {
        developer.log('Unauthorized');
      }
    } catch (e) {
      developer.log('Error: $e', name: 'error get user');
    }
  }

  // static updateUserProfile({String? name, bio, File? image}) async {
  //   try {
  //     String fileName = image!.path.split('/').last;
  //     developer.log(fileName, name: 'Filename photo');

  //     Directory appDir = await getApplicationDocumentsDirectory();

  //     String profileDirectoryPath = '${appDir.path}/assets';

  //     Directory profileDir = Directory(profileDirectoryPath);
  //     if (!profileDir.existsSync()) {
  //       profileDir.createSync(recursive: true);
  //     }

  //     String destinationPath = '$profileDirectoryPath/$fileName';

  //     await image.rename(destinationPath);

  //     developer.log('File copied to: $destinationPath', name: 'Filename Photo');
  //   } catch (e) {
  //     developer.log('Error copying image: $e', name: 'Copy Image Error');
  //   }

    // Upload image to server
    // String? token = await getToken();
    // var headers = {
    //   'X-Authorization': '$token',
    // };
    // final uri =
    //     Uri.parse(ApiEndPoints.baseUrl + UserEndPoints.updateUserProfile);
    // String fileName = image!.path.split('/').last;

    // try {
    //   var formData = dio.FormData.fromMap({
    //     'name': name,
    //     'bio': bio,
    //     'avatar': await dio.MultipartFile.fromFile(
    //       image.path,
    //       filename: fileName,
    //     ),
    //   });

    //   final response = await Dio()
    //       .put(ApiEndPoints.baseUrl + UserEndPoints.updateUserProfile,
    //           data: formData,
    //           options: Options(
    //             headers: headers,
    //           ));

    //   developer.log(response.statusCode.toString(),
    //       name: 'Response status code upload image');
    // } catch (e) {
    //   developer.log(e.toString(), name: 'error copy image');
    // }
  // }
}
