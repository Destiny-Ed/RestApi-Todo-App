
import 'dart:convert';

import 'package:rest_api_app/Constants/url.dart';
import 'package:rest_api_app/Model/task_model.dart';
import 'package:rest_api_app/Provider/Database/db_provider.dart';
import 'package:http/http.dart' as http;

class GetUserTask {

  final url = AppUrl.baseUrl;

  Future<TaskModel> getTask() async {
     final userId = await DatabaseProvider().getUserId();
    final token = await DatabaseProvider().getToken();

    String _url = "$url/users/$userId/tasks?lastId=&pagination=20";

    try {
      final request = await http
          .get(Uri.parse(_url), headers: {'Authorization': 'Bearer $token'});

      print(request.statusCode);

      if (request.statusCode == 200 || request.statusCode == 201){
        print(request.body);

        if (json.decode(request.body)['tasks'] == null) {
          return TaskModel();
        } else {
          final taskModel = taskModelFromJson(request.body);
          return taskModel;
        }
      } else {
        print(request.body);
        // final notificationModel = notificationModelFromJson(request.body);

        return TaskModel();
      }
    } catch (e) {
      print(e);
      return Future.error(e.toString());
    }

  }

}