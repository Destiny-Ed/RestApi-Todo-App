import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_app/Provider/TaskProvider/delete_task_provider.dart';
import 'package:rest_api_app/Styles/colors.dart';
import 'package:rest_api_app/Utils/snack_message.dart';
import 'package:rest_api_app/Widgets/button.dart';
import 'package:rest_api_app/Widgets/text_field.dart';

class TaskDetailsPage extends StatefulWidget {
  const TaskDetailsPage({Key? key, this.title, this.taskId}) : super(key: key);

  final String? title;
  final String? taskId;

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  final TextEditingController _title = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _title.text = widget.title!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task Details',
        ),
        actions: [
          Consumer<DeleteTaskProvider>(builder: (context, deleteTask, child) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              if (deleteTask.getResponse != '') {
                showMessage(message: deleteTask.getResponse, context: context);

                ///Clear the response message to avoid duplicate
                deleteTask.clear();
              }
            });
            return IconButton(
              onPressed: deleteTask.getStatus == true
                  ? null
                  : () {
                      deleteTask.deleteTask(
                          taskId: widget.taskId, ctx: context);
                    },
              icon: Icon(Icons.delete,
                  color: deleteTask.getStatus == true ? grey : white),
            );
          })
        ],
      ),
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
                  // customButton(
                  //   status: false,
                  //   text: 'Update',
                  //   tap: () {},
                  //   context: context,
                  // )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
