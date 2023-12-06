import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_bloc/core/colors/colors.dart';
import 'package:note_app_bloc/screens/add_notes/add_notes.dart';
import 'package:note_app_bloc/screens/edit_screen/edit_screen.dart';
import 'package:note_app_bloc/screens/home/home_bloc/home_bloc.dart';
import 'package:note_app_bloc/screens/home/home_bloc/home_event.dart';
import 'package:note_app_bloc/screens/widgets/dailogs_screen.dart';
import 'package:note_app_bloc/screens/widgets/note_card_widget.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({
    super.key,
  });

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FatchSuccessEvent());
  }

  late String id;
  late Map note;
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
      body: BlocConsumer<HomeBloc, HomeState>(
        buildWhen: (previous, current) => current is! HomeActionState,
        listenWhen: (previous, current) => current is HomeActionState,
        listener: (context, state) {
          if (state is FromNavigationState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenAddForm(),
                ));
          } else if (state is ShowPopupMessageState) {
            alertMessage(context, id);
          } else if (state is UpdateNavigationState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EDITSCREEN(id: state.id, map: state.map),
                ));
          }
        },
        builder: (context, state) {
          if (state is SuccessState) {
            return GridView.count(
              padding: const EdgeInsets.all(8),
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: List.generate(state.notesList.length, (index) {
                note = state.notesList[index] as Map;
                id = note['_id'];
                return NoteCardWidget(id: id, note: note);
              }),
            );
          } else if (state is LoadingState) {
            return const SizedBox.expand(
                child: Center(child: CircularProgressIndicator()));
          } else {
            return const SizedBox.expand(
              child: Center(child: Text('empty notes')),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<HomeBloc>().add(FromNavigationEvent()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
