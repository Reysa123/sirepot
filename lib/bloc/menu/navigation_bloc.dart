import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirepot/repository/repository.dart';
import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationStates(0, [])) {
    on<ChangeMenuEvent>((event, emit) async {
      emit(Loading());
      Future.delayed(Duration(seconds: 1));
      final image = await KpiRepository().getImage();
      await KpiRepository().listPetugas();
      emit(NavigationStates(event.index, image));
    });
  }
}
