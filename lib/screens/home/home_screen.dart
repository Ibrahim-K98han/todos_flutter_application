import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:todos_flutter_application/controllers/todo_controller.dart';
import 'package:todos_flutter_application/routes.dart';
import 'package:todos_flutter_application/utils/shared_prefs.dart';
import 'package:todos_flutter_application/widgets/custom_button.dart';
import 'package:todos_flutter_application/widgets/custom_search.dart';
import 'package:todos_flutter_application/widgets/custom_textfield.dart';
import 'package:todos_flutter_application/widgets/loader.dart';

import '../../models/all_todo_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TASKS',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const Dialog(
                  child: ManipulateTodo(),
                ),
              );
            },
            icon: const FaIcon(
              FontAwesomeIcons.plus,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Logout?'),
                  content: Text('Are you sure you want to logout?'),
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () async {
                        await SharedPrefs().removeUser();
                        Get.offAllNamed(Routes.login);
                      },
                      child: const Text(
                        'Confirm',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              );
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowRightFromBracket,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GetBuilder<TodoController>(builder: (controller) {
          return Column(
            children: [
              CustomSearch(
                onChanged: (val) {
                  controller.search(val);
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: controller.filteredTodo
                        .map(
                          (todo) => Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    controller.titleController.text =
                                        todo.title!;
                                    controller.descriptionController.text =
                                        todo.description!;
                                    controller.update();
                                    showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                        child: ManipulateTodo(
                                          edit: true,
                                          id: todo.id!,
                                        ),
                                      ),
                                    );
                                  },
                                  backgroundColor: const Color(0xff8394FF),
                                  foregroundColor: Colors.white,
                                  icon: FontAwesomeIcons.pencil,
                                  label: 'Edit',
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Delete Todo?'),
                                        content: const Text(
                                            'Are you sure you want to delete this todo?'),
                                        actions: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green,
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                            ),
                                            onPressed: () async {
                                              await Get.showOverlay(
                                                asyncFunction: () => controller
                                                    .deleteTodo(todo.id),
                                                loadingWidget: const Loader(),
                                              );
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'Confirm',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: FontAwesomeIcons.trash,
                                  label: 'Delete',
                                )
                              ],
                            ),
                            child: TodoTile(
                              todo: todo,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

class TodoTile extends StatelessWidget {
  TodoTile({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x29000000),
            offset: Offset(0, 5),
            blurRadius: 5,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                todo.title!,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                todo.date!,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Text(
            todo.description!,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}

class ManipulateTodo extends StatelessWidget {
  const ManipulateTodo({
    super.key,
    this.edit = false,
    this.id = '',
  });
  final bool edit;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GetBuilder<TodoController>(builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${edit ? "Edit" : "Add"} Todo",
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
              hint: 'Title',
              controller: controller.titleController,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: 'Description',
              maxLines: 5,
              controller: controller.descriptionController,
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              label: edit ? 'Edit' : 'Add',
              onPressed: () async {
                if (!edit) {
                  await Get.showOverlay(
                    asyncFunction: () => controller.addTodo(),
                    loadingWidget: const Loader(),
                  );
                } else {
                  await Get.showOverlay(
                    asyncFunction: () => controller.editTodo(id),
                    loadingWidget: const Loader(),
                  );
                }

                Navigator.pop(context);
              },
            )
          ],
        );
      }),
    );
  }
}
