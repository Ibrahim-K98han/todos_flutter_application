import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:todos_flutter_application/controllers/todo_controller.dart';
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
          'TODO',
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
                                  onPressed: (context) {},
                                  backgroundColor: const Color(0xff8394FF),
                                  foregroundColor: Colors.white,
                                  icon: FontAwesomeIcons.pencil,
                                  label: 'Edit',
                                ),
                                SlidableAction(
                                  onPressed: (context) {},
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
                  fontSize: 20,
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
  const ManipulateTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GetBuilder<TodoController>(builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add Todo',
              style: TextStyle(
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
              label: 'Add',
              onPressed: () async {
                await Get.showOverlay(
                  asyncFunction: () => controller.addTodo(),
                  loadingWidget: const Loader(),
                );
                Navigator.pop(context);
              },
            )
          ],
        );
      }),
    );
  }
}
