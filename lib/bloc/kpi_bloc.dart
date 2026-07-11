import 'package:sirepot/bloc/kpi_event.dart';
import 'package:sirepot/bloc/kpi_state.dart';
import 'package:sirepot/model/service_reminder.dart';
import 'package:sirepot/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KpiBloc extends Bloc<KpiEvent, KpiState> {
  final KpiRepository repository;
  late KpiLoaded currentState;
  final int pageSize = 13; // Sesuai baris yang ditampilkan di PDF
  late List<ServiceReminder> data;
  String unopol = "";
  KpiBloc(this.repository) : super(KpiInitial()) {
    on<FetchKpiData>((event, emit) async {
      emit(KpiLoading());
      try {
        data = await repository.fetchKpiData(event.page, pageSize);
        final sbe = await repository.fetchPotensi();
        final program = await repository.fetchProgram();
        final repair = await repository.fetchRepair();
        final month = await repository.fetchMonth();
        final area = await repository.fetchArea();
        final listPetugas = await repository.listPetugas();
        // Cek apakah data yang datang kurang dari pageSize, berarti sudah habis
        bool reachedMax = data.length < pageSize;
        currentState = KpiLoaded(
          listPetugas: listPetugas,
          data: data,
          sbe: sbe,
          month: month,
          repair: repair,
          program: program,
          area: area,
          currentPage: event.page,
          hasReachedMax: reachedMax,
        );
        emit(
          KpiLoaded(
            listPetugas: listPetugas,
            data: data,
            sbe: sbe,
            month: month,
            repair: repair,
            program: program,
            area: area,
            currentPage: event.page,
            hasReachedMax: reachedMax,
          ),
        );
      } catch (e) {
        emit(KpiError("Gagal memuat data dashboard.${e.toString()}"));
      }
    });
    on<SearchKpiData>((event, emit) async {
      if (state is KpiLoaded) {
        final currentStates = state as KpiLoaded;
        final query = event.query.toLowerCase();
        try {
          emit(KpiLoading());

          final filteredData = currentStates.data.where((item) {
            final policeNo = item.policeNo?.toLowerCase() ?? '';
            final namaPelanggan = item.namaPelanggan?.toLowerCase() ?? '';
            final potensi = item.potensi?.toLowerCase() ?? '';

            return policeNo.contains(query) ||
                namaPelanggan.contains(query) ||
                potensi.contains(query);
          }).toList();

          emit(
            currentStates.copyWith(
              data: filteredData,
              sbe: currentState.sbe,
              month: currentState.month,
              repair: currentState.repair,
              program: currentState.program,
            ),
          );
        } catch (e) {
          emit(KpiError("Gagal memuat data dashboard.${e.toString()}"));
        }
      }
    });
    on<FilterKpiData>((event, emit) async {
      if (state is KpiLoaded) {
        emit(KpiLoading());
        //final currentState = state as KpiLoaded;
        if (event.reload) {
          data = await repository.fetchKpiData(0, 0);
        }
        // Update state dengan pilihan dropdown yang baru
        final updatedRepair = event.repair == "null" ? null : event.repair;
        final updatedSbe = event.sbe == "null" ? null : event.sbe;
        final updatedProgram = event.program == "null" ? null : event.program;
        final updatedMonth = event.month == "null" ? null : event.month;
        final updateNopol = event.nopol ?? event.nopol;
        final updateArea = event.area == "null" ? null : event.area;
        //Tampilkan loading jika perlu
        //emit(KpiLoading());

        //Lakukan filter data (Bisa dari lokal/List master, atau API Fetching ulang)
        final filteredData = data.where((item) {
          final urep =
              updatedRepair == null || item.repairType!.contains(updatedRepair);
          final uprog =
              updatedProgram == null || item.program!.contains(updatedProgram);
          final umonth =
              updatedMonth == null ||
              item.month!.toLowerCase().contains(updatedMonth.toLowerCase());
          final upotensi =
              updatedSbe == null ||
              item.potensi!.toLowerCase().contains(updatedSbe.toLowerCase());
          final unopol =
              updateNopol == null ||
              item.policeNo!.toLowerCase().contains(event.nopol!.toLowerCase());
          final uarea =
              updateArea == null ||
              item.area!.toLowerCase().contains(event.area!.toLowerCase());
          return urep && uprog && umonth && unopol && upotensi && uarea;
        }).toList();

        emit(
          currentState.copyWith(
            selectedRepair: updatedRepair,
            selectedSbe: updatedSbe,
            selectedProgram: updatedProgram,
            selectedMonth: updatedMonth,
            selectedNopol: updateNopol,
            selectedArea: updateArea,
            data: filteredData, // Masukkan data yang sudah di-filter di sini
          ),
        );
      }
    });
  }
}
