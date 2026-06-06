import 'package:sirepot/bloc/cr7/cr7event.dart';
import 'package:sirepot/bloc/cr7/cr7state.dart';
import 'package:sirepot/model/service_reminder.dart';
import 'package:sirepot/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Cr7Bloc extends Bloc<Cr7Event, Cr7State> {
  List<CR7> _masterData = [];
  final KpiRepository repository;
  final int pageSize = 13; // Sesuai baris yang ditampilkan di PDF
  String unopol = "";
  Cr7Bloc(this.repository) : super(Cr7Initial()) {
    on<FetchCr7Data>((event, emit) async {
      emit(Cr7Loading());
      try {
        emit(Cr7Loading());
        _masterData = await repository.fetchcr7(event.page, pageSize);
        final sa = await repository.fetchSa();
        final month = await repository.fetchMonth();
        // Cek apakah data yang datang kurang dari pageSize, berarti sudah habis
        bool reachedMax = _masterData.length < pageSize;
        emit(
          Cr7Loaded(
            data: _masterData,
            sa: sa,
            month: month,
            currentPage: event.page,
            hasReachedMax: reachedMax,
          ),
        );
      } catch (e) {
        emit(Cr7Error("Gagal memuat data dashboard.${e.toString()}"));
      }
    });
    on<FilterCr7Data>((event, emit) {
      if (state is Cr7Loaded) {
        final currentState = state as Cr7Loaded;

        // Tangkap nilai dropdown yang baru di-klik, atau gunakan yang lama jika null
        final selectedSa = event.sa == "null" ? null : event.sa;
        final selectedMonth = event.month == "null" ? null : event.month;

        // Lakukan filter pada _masterData
        final filteredList = _masterData.where((item) {
          final matchMonth =
              selectedMonth == null ||
              (DateFormat(
                "MMMM",
                "id",
              ).format(DateTime.parse(item.month!)).toLowerCase()).contains(
                event.month!.toLowerCase(),
              );

          final matchSa =
              selectedMonth == null ||
              item.sa!.toLowerCase().contains(event.sa!.toLowerCase());

          return matchSa && matchMonth;
        }).toList();

        // Update state menggunakan copyWith dengan data hasil filter
        emit(
          currentState.copyWith(
            selectedSa: selectedSa,
            selectedMonth: selectedMonth,
            data: filteredList,
          ),
        );
      }
    });
    on<SearchCr7Data>((event, emit) async {
      if (state is Cr7Loaded) {
        final currentState = state as Cr7Loaded;
        unopol = event.query.toLowerCase();
        try {
          emit(Cr7Loading());

          final filteredData = currentState.data
              .where(
                (item) => item.policeNo!.toLowerCase().contains(
                  event.query.toLowerCase(),
                ),
              )
              .toList();

          emit(
            currentState.copyWith(
              data: filteredData,
              sa: currentState.sa,
              month: currentState.month,
            ),
          );
        } catch (e) {
          emit(Cr7Error("Gagal memuat data dashboard.${e.toString()}"));
        }
      }
    });
  }
}
