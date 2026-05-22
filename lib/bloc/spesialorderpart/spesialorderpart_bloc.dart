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
  }
}
