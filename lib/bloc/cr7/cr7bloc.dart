import 'package:sirepot/bloc/cr7/cr7event.dart';
import 'package:sirepot/bloc/cr7/cr7state.dart';
import 'package:sirepot/model/service_reminder.dart';
import 'package:sirepot/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cr7Bloc extends Bloc<Cr7Event, Cr7State> {
  List<CR7> _masterData = [];
  final KpiRepository repository;
  final int pageSize = 13; // Sesuai baris yang ditampilkan di PDF

  Cr7Bloc(this.repository) : super(Cr7Initial()) {
    on<FetchCr7Data>((event, emit) async {
      emit(Cr7Loading());
      try {
        emit(Cr7Loading());
        _masterData = await repository.fetchcr7(event.page, pageSize);
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
        final selectedSa = event.sa ?? currentState.selectedSa;
        final selectedMonth = event.month ?? currentState.selectedMonth;

        // Lakukan filter pada _masterData
        List<CR7> filteredList = _masterData.where((item) {
          bool matchSa = true;
          bool matchMonth = true;

          // Sesuaikan logika pengecekan dengan properti yang ada di model CR7 Anda
          if (selectedSa != null && selectedSa.isNotEmpty) {
            // matchSa = item.saName == selectedSa; // Contoh jika ada properti saName
          }

          if (selectedMonth != null && selectedMonth.isNotEmpty) {
            // matchMonth = item.month == selectedMonth; // Contoh jika ada properti month
          }

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
        final query = event.query.toLowerCase();

        // Jika kolom pencarian kosong, kembalikan data yang difilter berdasarkan dropdown aktif
        if (query.isEmpty) {
          // Trigger ulang event filter dengan state yang sedang aktif untuk me-reset tabel
          add(
            FilterCr7Data(
              sa: currentState.selectedSa,
              month: currentState.selectedMonth,
            ),
          );
          return;
        }
        // Lakukan filter pencarian text pada _masterData
        List<CR7> searchedList = _masterData.where((item) {
          return item.policeNo.toLowerCase().contains(query);
        }).toList();

        // Tetap pertahankan value dropdown saat ini, tapi ubah data tabelnya
        emit(currentState.copyWith(data: searchedList));
      }
    });
  }
}
