import 'package:sirepot/bloc/cr7/cr7event.dart';
import 'package:sirepot/bloc/cr7/cr7state.dart';
import 'package:sirepot/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cr7Bloc extends Bloc<Cr7Event, Cr7State> {
  final KpiRepository repository;
  final int pageSize = 13; // Sesuai baris yang ditampilkan di PDF

  Cr7Bloc(this.repository) : super(Cr7Initial()) {
    on<FetchCr7Data>((event, emit) async {
      emit(Cr7Loading());
      try {
        emit(Cr7Loading());
        final data = await repository.fetchcr7(event.page, pageSize);
        final sa = ["Budi", "Wati", "Iwan"];
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
          Cr7Loaded(
            data: data,
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
    // 2. Handler Baru untuk Search Data
    on<SearchCr7Data>((event, emit) async {
      final currentState = state;
      if (currentState is Cr7Loaded) {
        emit(Cr7Loading());
        try {
          // Silakan sesuaikan method repository Anda untuk menerima query pencarian, contoh:
          final data = await repository.fetchcr7(0, pageSize);
          // Filter dummy jika repository belum mendukung pencarian (opsional):
          final filteredData = data
              .where(
                (item) => item.policeNo.toLowerCase().contains(
                  event.query.toLowerCase(),
                ),
              )
              .toList();

          emit(
            Cr7Loaded(
              data: filteredData, // Gunakan hasil filter
              sa: currentState.sa,
              month: currentState.month,
              currentPage: 0,
              hasReachedMax:
                  true, // Set true karena hasil search biasanya fixed
            ),
          );
        } catch (e) {
          emit(Cr7Error("Gagal mencari data.${e.toString()}"));
        }
      }
    });
  }
}
