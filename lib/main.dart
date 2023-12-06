import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_bloc/screens/add_notes/add_note_bloc/add_bloc.dart';
import 'package:note_app_bloc/screens/edit_screen/edit_bloc/edit_bloc.dart';
import 'package:note_app_bloc/screens/home/home_bloc/home_bloc.dart';
import 'package:note_app_bloc/screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => AddBloc(),
        ),
        BlocProvider(
          create: (context) => EditBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
      
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor:const Color.fromARGB(255, 255, 255, 255),
              background:const Color.fromARGB(255, 211, 209, 209)),
          useMaterial3: true,
        ),
        // home: const ScreenHome(),
      ),
    );
  }  
}
