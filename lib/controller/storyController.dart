// import 'package:aksi_seru_app/controller/user.dart';
// import 'package:aksi_seru_app/utils/api.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:http/http.dart' as http;
// import 'dart:developer' as developer;

// class StoryController extends GetxController {
//   static Future<void> createStory(String image) async {
//     String? token = await UserData.getToken();

//     var headers = {
//       'X-Authorization': '$token',
//     };

//     Map<String, dynamic> dataBody = {
//       'image': 'ssss',
//     };
//     final uri = Uri.parse(ApiEndPoints.baseUrl + Story.createStory);

//     try {
//       final response = await http.post(uri, headers: headers, body: dataBody);
//       if (response.statusCode == 200) {
//         developer.log('success');
//       } else if (response.statusCode == 401) {
//         developer.log('Unauthorized');
//       }
//       developer.log(response.body, name: 'response body');
//     } catch (e) {
//       developer.log('Error: $e', name: 'error get user');
//     }
//   }
// }
