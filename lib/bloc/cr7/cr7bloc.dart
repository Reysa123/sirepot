
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

        // Cek apakah data yang datang kurang dari pageSize, berarti sudah habis
        bool reachedMax = data.length < pageSize;
        emit(
          Cr7Loaded(
            data: data,
            currentPage: event.page,
            hasReachedMax: reachedMax,
          ),
        );
      } catch (e) {
        emit(Cr7Error("Gagal memuat data dashboard.${e.toString()}"));
      }
    });
  }
}
