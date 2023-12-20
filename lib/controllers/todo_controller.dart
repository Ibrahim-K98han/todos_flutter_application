import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:todos_flutter_application/models/all_todo_model.dart';
import 'package:todos_flutter_application/models/user_model.dart';
import 'package:todos_flutter_application/utils/baseurl.dart';
import 'package:todos_flutter_application/utils/custom_snackbar.dart';
import 'package:todos_flutter_application/utils/shared_prefs.dart';

class TodoController extends GetxController {
  List<Todo> todos = [];
  List<Todo> filteredTodo = [];
  @override
  void onInit() {
    fetchMyTodos();
    super.onInit();
  }

  fetchMyTodos() async {
    var user = await SharedPrefs().getUser();
    UserModel userModel = UserModel.fromJson(json.decode(user));

    var response = await http.post(Uri.parse('${baseurl}todos.php'),
        body: {'user_id': userModel.id});
    var res = await json.decode(response.body);

    if (res['success']) {
      todos = AllTodoModel.fromJson(res).todo!;
      filteredTodo = AllTodoModel.fromJson(res).todo!;
      update();
    } else {
      customSnackbar('Error', 'Failed to fetch todos', 'error');
    }
  }

  search(String val) {
    if (val.isEmpty) {
      filteredTodo = todos;
      update();
      return;
    }
    filteredTodo = todos.where((todo) {
      return todo.title!.toLowerCase().contains(val.toLowerCase());
    }).toList();
    update();
  }
}
