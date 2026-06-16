import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationStates(0)) {
    on<ChangeMenuEvent>((event, emit) {
      emit(Loading());
      Future.delayed(Duration(seconds: 2));
      emit(NavigationStates(event.index));
    });
  }
}
