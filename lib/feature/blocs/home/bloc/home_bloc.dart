import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>(_onHomeStarted);
    on<BottomSheetEvent>(_onBottomSheetInitial);
  }

  void _onHomeStarted(HomeEvent event, Emitter<HomeState> emit) {
    emit(HomeInitial());
  }

  void _onBottomSheetInitial(BottomSheetEvent event, Emitter<HomeState> emit) {
    emit(BottomSheetInitial());
    emit(event.isOpened ? BottomSheetOpened() : BottomSheetClosed());
  }

  void handleBottomSheetOpened(BuildContext context, bool isOpened) {
    isOpened = true;
    context.read<HomeBloc>().add(
          BottomSheetEvent(
            isOpened: isOpened,
          ),
        );
  }

  void handleBottomSheetClosed(BuildContext context, bool isClosed) {
    isClosed = false;
    context.read<HomeBloc>().add(
          BottomSheetEvent(
            isOpened: isClosed,
          ),
        );
  }
}
