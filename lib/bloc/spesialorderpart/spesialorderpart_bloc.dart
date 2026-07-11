import 'package:sirepot/bloc/spesialorderpart/spesialorderpart_event.dart';
import 'package:sirepot/bloc/spesialorderpart/spesialorderpart_state.dart';
import 'package:sirepot/model/service_reminder.dart';
import 'package:sirepot/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpesialOrderPartBloc
    extends Bloc<SpesialOrderPartEvent, SpesialOrderPartState> {
  List<SpesialOrderPart> _masterData = [];
  final KpiRepository repository;
  final int pageSize = 13; // Sesuai baris yang ditampilkan di PDF

  SpesialOrderPartBloc(this.repository) : super(SpesialOrderPartInitial()) {
    on<FetchSpesialOrderPartData>((event, emit) async {
      emit(SpesialOrderPartLoading());
      try {
        emit(SpesialOrderPartLoading());
        _masterData = await repository.fetchSpesialOrder(event.page, pageSize);
        final List<String> sa = await repository.fetchSa();
        final List<String> sales = ["Ari", "Wawan", "Fadli"];
        final List<String> vin = await repository.fetchVin();
        final List<String> model = ["Model A", "Model B"];
        // Cek apakah data yang datang kurang dari pageSize, berarti sudah habis
        bool reachedMax = _masterData.length < pageSize;
        emit(
          SpesialOrderPartLoaded(
            data: _masterData,
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
    on<FilterSpesialOrderPartData>((event, emit) {
      if (state is SpesialOrderPartLoaded) {
        final currentState = state as SpesialOrderPartLoaded;

        // Ambil nilai SA yang baru, atau gunakan yang lama
        final selectedSa = event.sa == "null" ? null : event.sa;
        final selectedSales = event.sales == "null" ? null : event.sales;
        final selectedVin = event.vin == "null" ? null : event.vin;
        final selectedModel = event.model ?? currentState.selectedModel;
        final selectNopol = event.nopol ?? event.nopol;
        // Filter _masterData
        List<SpesialOrderPart> filteredList = _masterData.where((item) {
          final matchSa =
              selectedSa == null ||
              item.sa.toLowerCase().contains(event.sa!.toLowerCase());
          final matchNopol =
              selectNopol == null ||
              item.policeNo.toLowerCase().contains(event.nopol!.toLowerCase());
          return matchSa && matchNopol;
        }).toList();

        // Update state
        emit(
          currentState.copyWith(
            selectedSa: selectedSa,
            selectedSales: selectedSales,
            selectedModel: selectedModel,
            selectedVin: selectedVin,
            selectedNopol: selectNopol,
            data: filteredList,
          ),
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
