import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_bloc/core/colors/colors.dart';
import 'package:note_app_bloc/screens/edit_screen/edit_bloc/edit_bloc.dart';
import 'package:note_app_bloc/screens/edit_screen/edit_bloc/edit_event.dart';
import 'package:note_app_bloc/screens/edit_screen/edit_bloc/edit_state.dart';
import 'package:note_app_bloc/screens/home/home_bloc/home_bloc.dart';
import 'package:note_app_bloc/screens/home/home_bloc/home_event.dart';

final titleController = TextEditingController();
final descriptionController = TextEditingController();
final formKey = GlobalKey<FormState>();

class EDITSCREEN extends StatefulWidget {
  const EDITSCREEN({super.key, required this.id, required this.map});

  final String id;
  final Map map;

  @override
  State<EDITSCREEN> createState() => _EDITSCREENState();
}

class _EDITSCREENState extends State<EDITSCREEN> {
  @override
  void initState() {
    super.initState();
    final note = widget.map;
    titleController.text = note['title'];
    descriptionController.text = note['description'];
  }

  @override
  void dispose() {
    super.dispose();
    titleController.text = '';
    descriptionController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'EDIT SCREEN',
            style: TextStyle(color: whitecolor),
          ),
          centerTitle: true,
          backgroundColor: Blackcolor,
        ),
        body: BlocConsumer<EditBloc, EditState>(
          listener: (context, state) {
            if (state is EditSuccessState) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(10),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.green,
                content: Text(
                  'Update Successfull',
                  style: TextStyle(color: Colors.white),
                ),
              ));
              context.read<HomeBloc>().add(FatchSuccessEvent());
            } else if (state is EditFaildState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(10),
                  duration: Duration(seconds: 1),
                  backgroundColor: Colors.red,
                  content: Text(
                    "did npt upate",
                    style: TextStyle(color: Colors.white),
                  )));
            }
          },
          builder: (context, state) {
            return Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                        ),
                        validator: (value) => titleController.text.isEmpty
                            ? 'please enter a name'
                            : null,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 30),
                      child: SizedBox(
                        height: 220,
                        child: TextFormField(
                          controller: descriptionController,
                          maxLines: 10,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Note',
                          ),
                          validator: (value) => titleController.text.isEmpty
                              ? 'please enter a name'
                              : null,
                        ),
                      ),
                    ),
                Row(
                  children: [
                        Padding(
                      padding:
                          const EdgeInsets.only(left: 60,  top: 40),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Blackcolor),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              update(context, widget.id);
                            }
                          },
                          child: const Text('Update',
                              style: TextStyle(color: whitecolor),),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only( top: 40,left: 60),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary:  Blackcolor),
                        onPressed: (){
                        if(formKey.currentState!.validate()){
                            update(context, widget.id);
                        }
                      }, child:const Text('Patch', style:
                       TextStyle(color:  whitecolor))),
                    ),
                  ],
                )
                  ],
                ),
              ),
            );
          },
        ));
  }



  void update(BuildContext context, String id) {
    final title = titleController.text;
    final description = descriptionController.text;

    final map = {
      'title': title,
      'description': description,
    };
    context.read<EditBloc>().add(EditNoteEvent(id: id, map: map));
  }
}
