import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirepot/repository/repository.dart';
import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc()
    : super(
        NavigationStates([
          const AssetImage("images/background.jpg"),
          const AssetImage("images/sireport.png"),
          const AssetImage("images/agung.png"),
        ]),
      ) {
    
    on<LoadingMenu>((event, emit) async {
      emit(Loading());
      List<ImageProvider> image = [];
      try {
        // Mengambil data dari repository
        image = await KpiRepository().getImage();
        await KpiRepository().listPetugas();
      } catch (e) {
        debugPrint(e.toString());
      }
      
      // Setelah loading selesai, kirim state awal (index 0)
      emit(NaviNull(0, image.isNotEmpty ? image : state.images));
    });

    on<ChangeMenuEvent>((event, emit) async {
      // Mengambil list image dari state saat ini agar tidak hilang saat berpindah menu
      final currentImages = state.images;
      emit(NaviNull(event.index, currentImages));
    });
  }
}