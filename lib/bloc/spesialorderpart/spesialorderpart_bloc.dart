import 'package:sirepot/bloc/spesialorderpart/spesialorderpart_event.dart';
import 'package:sirepot/bloc/spesialorderpart/spesialorderpart_state.dart';
import 'package:sirepot/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpesialOrderPartBloc
    extends Bloc<SpesialOrderPartEvent, SpesialOrderPartState> {
  final KpiRepository repository;
  final int pageSize = 13; // Sesuai baris yang ditampilkan di PDF

  SpesialOrderPartBloc(this.repository) : super(SpesialOrderPartInitial()) {
    on<FetchSpesialOrderPartData>((event, emit) async {
      emit(SpesialOrderPartLoading());
      try {
        emit(SpesialOrderPartLoading());
        final data = await repository.fetchSpesialOrder(event.page, pageSize);
        final List<String> sa = ["Budi", "Iwan", "Wati"];
        final List<String> sales = ["Ari", "Wawan", "Fadli"];
        final List<String> vin = ["MHC"];
        final List<String> model = ["Model A", "Model B"];
        // Cek apakah data yang datang kurang dari pageSize, berarti sudah habis
        bool reachedMax = data.length < pageSize;
        emit(
          SpesialOrderPartLoaded(
            data: data,
            sa: sa,
            sales: sales,
            vin: vin,
            model: model,
            currentPage: event.page,
            hasReachedMax: reachedMax,
          ),
        );
      } catch (e) {
        emit(
          SpesialOrderPartError("Gagal memuat data dashboard.${e.toString()}"),
        );
      }
    });
    // 2. Handler Baru untuk Search Data
    on<SearchSpesialOrderPartData>((event, emit) async {
      final currentState = state;
      if (currentState is SpesialOrderPartLoaded) {
        emit(SpesialOrderPartLoading());
        try {
          // Silakan sesuaikan method repository Anda untuk menerima query pencarian, contoh:
          final data = await repository.fetchSpesialOrder(0, pageSize);
          // Filter dummy jika repository belum mendukung pencarian (opsional):
          final filteredData = data
              .where(
                (item) => item.policeNo.toLowerCase().contains(
                  event.query.toLowerCase(),
                ),
              )
              .toList();

          emit(
            SpesialOrderPartLoaded(
              data: filteredData, // Gunakan hasil filter
              sa: currentState.sa,
              sales: currentState.sales,
              vin: currentState.vin,
              model: currentState.model,
              currentPage: 0,
              hasReachedMax:
                  true, // Set true karena hasil search biasanya fixed
            ),
          );
        } catch (e) {
          emit(SpesialOrderPartError("Gagal mencari data.${e.toString()}"));
        }
      }
    });
  }
}
