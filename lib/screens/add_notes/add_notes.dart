import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_bloc/core/colors/colors.dart';
import 'package:note_app_bloc/screens/add_notes/add_note_bloc/add_bloc.dart';
import 'package:note_app_bloc/screens/add_notes/add_note_bloc/add_event.dart';
import 'package:note_app_bloc/screens/add_notes/add_note_bloc/add_state.dart';
import 'package:note_app_bloc/screens/home/home_bloc/home_bloc.dart';
import 'package:note_app_bloc/screens/home/home_bloc/home_event.dart';

final titleController = TextEditingController();
final descriptionController = TextEditingController();
final formKey = GlobalKey<FormState>();

class ScreenAddForm extends StatelessWidget {
  const ScreenAddForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ADD NOTES',
          style: TextStyle(color: whitecolor),
        ),
        centerTitle: true,
        backgroundColor: Blackcolor,
      ),
      body: BlocConsumer<AddBloc, AddState>(
        buildWhen: (previous, current) => current is! AddActionState,
        listenWhen: (previous, current) => current is AddActionState,
        listener: (context, state) {
          if (state is AddNoteSuccessState) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(10),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.green,
                content: Text(
                  "Data Added Successfuly!!",
                  style: TextStyle(color: Colors.white),
                )));
            context.read<HomeBloc>().add(FatchSuccessEvent());
          } else if (state is AddNoteErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(10),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.red,
                content: Text(
                  "Data Not Added !!",
                  style: TextStyle(color: Colors.white),
                )));
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Title',
                        hintStyle: TextStyle(fontSize: 20)),
                    validator: (value) => titleController.text.isEmpty
                        ? 'Please enter a title'
                        : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 10,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Description',
                        hintStyle: TextStyle(fontSize: 20)),
                    validator: (value) => descriptionController.text.isEmpty
                        ? 'Please enter a description'
                        : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 90, right: 90, top: 30),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Blackcolor),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            submitData(context);
                          }
                        },
                        child: const Text('Submit',
                            style: TextStyle(color: whitecolor))),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void submitData(BuildContext context) {
  final title = titleController.text;
  final description = descriptionController.text;
  final map = {
    "title": title,
    "description": description,
    "is_completed": false
  };
  context.read<AddBloc>().add(AddNoteEvent(map: map));
  titleController.text = '';
  descriptionController.text = '';
}
