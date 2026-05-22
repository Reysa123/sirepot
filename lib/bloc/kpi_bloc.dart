import 'package:sirepot/bloc/kpi_event.dart';
import 'package:sirepot/bloc/kpi_state.dart';
import 'package:sirepot/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KpiBloc extends Bloc<KpiEvent, KpiState> {
  final KpiRepository repository;
  final int pageSize = 13; // Sesuai baris yang ditampilkan di PDF

  KpiBloc(this.repository) : super(KpiInitial()) {
    on<FetchKpiData>((event, emit) async {
      emit(KpiLoading());
      try {
        emit(KpiLoading());
        final data = await repository.fetchKpiData(event.page, pageSize);
        final sbe = ["z", "r", "t"];
        final program = ["h", "f", "s"];
        final repair = ["a", "b", "c"];
        final month = [
          "Januari",
          "Februari",
          "Maret",
          "April",
          "Mei",
          "Juni",
          "Juli",
          "Agustus",
          "September",
          "Oktober",
          "November",
          "Desember",
        ];
        // Cek apakah data yang datang kurang dari pageSize, berarti sudah habis
        bool reachedMax = data.length < pageSize;
        emit(
          KpiLoaded(
            data: data,
            sbe: sbe,
            month: month,
            repair: repair,
            program: program,
            currentPage: event.page,
            hasReachedMax: reachedMax,
          ),
        );
      } catch (e) {
        emit(KpiError("Gagal memuat data dashboard.${e.toString()}"));
      }
    });
    on<SearchKpiData>((event, emit) async {
      final currentState = state;
      if (currentState is KpiLoaded) {
        emit(KpiLoading());
        try {
          emit(KpiLoading());
          final data = await repository.fetchKpiData(0, pageSize);
          final filteredData = data
              .where(
                (item) => item.policeNo.toLowerCase().contains(
                  event.query.toLowerCase(),
                ),
              )
              .toList();
          // Cek apakah data yang datang kurang dari pageSize, berarti sudah habis
          bool reachedMax = data.length < pageSize;
          emit(
            KpiLoaded(
              data: filteredData,
              sbe: currentState.sbe,
              month: currentState.month,
              repair: currentState.repair,
              program: currentState.program,
              currentPage: 0,
              hasReachedMax: reachedMax,
            ),
          );
        } catch (e) {
          emit(KpiError("Gagal memuat data dashboard.${e.toString()}"));
        }
      }
    });
  }
}
