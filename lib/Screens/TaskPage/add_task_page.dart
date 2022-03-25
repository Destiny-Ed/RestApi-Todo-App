import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_app/Provider/TaskProvider/add_task_provider.dart';
import 'package:rest_api_app/Utils/snack_message.dart';
import 'package:rest_api_app/Widgets/button.dart';
import 'package:rest_api_app/Widgets/text_field.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({Key? key}) : super(key: key);

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final TextEditingController _title = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Task')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  customTextField(
                    title: 'Title',
                    controller: _title,
                    hint: 'What do you want to do?',
                  ),
                  Consumer<AddTaskProvider>(builder: (context, addTask, child) {
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      if (addTask.getResponse != '') {
                        showMessage(
                            message: addTask.getResponse, context: context);

                        ///Clear the response message to avoid duplicate
                        addTask.clear();
                      }
                    });
                    return customButton(
                      status: addTask.getStatus,
                      tap: () {
                        if (_title.text.isEmpty) {
                          showMessage(
                              message: "Fill in title", context: context);
                        } else {
                          addTask.addTask(title: _title.text.trim());
                        }
                      },
                      context: context,
                    );
                  })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
