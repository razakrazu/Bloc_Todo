import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:note_app_bloc/api_functions/api_function.dart';

import 'package:note_app_bloc/screens/home/home_bloc/home_event.dart';
part 'home_start.dart';



class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FromNavigationEvent>(formNavigation);
    on<FatchSuccessEvent>(fetchDatas);
    on<ShowDialogEvent>(showDialogEvent);
    on<DeleteNoteEvent>(deleteNoteEvent);
    on<UpdateNavigationEvent>(updateNavigation);
  }

  FutureOr<void> formNavigation(
      FromNavigationEvent event, Emitter<HomeState> emit) {
    emit(FromNavigationState());
  }

  FutureOr<void> fetchDatas(
      FatchSuccessEvent event, Emitter<HomeState> emit) async {
    emit(LoadingState());
    final notes = await Api.fatchNode();
    if (notes!.isNotEmpty) {
      emit(SuccessState(notesList: notes));
    } else {
      emit(ErrorState());
    }
  }

  FutureOr<void> deleteNoteEvent(
      DeleteNoteEvent event, Emitter<HomeState> emit) {
    Api.deleteById(event.id);
    emit(DeleteNoteMessageState());
  }

  FutureOr<void> showDialogEvent(
      ShowDialogEvent event, Emitter<HomeState> emit) {
    emit(ShowPopupMessageState());
  }

  FutureOr<void> updateNavigation(
      UpdateNavigationEvent event, Emitter<HomeState> emit) {
    emit(UpdateNavigationState(id: event.id, map: event.map));
  }
}
