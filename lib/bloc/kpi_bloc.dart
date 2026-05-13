class KpiBloc extends Bloc<KpiEvent, KpiState> {
  final KpiRepository repository;
  final int pageSize = 13; // Sesuai baris yang ditampilkan di PDF 

  KpiBloc(this.repository) : super(KpiInitial()) {
    on<FetchKpiData>((event, emit) async {
      try {
        emit(KpiLoading());
        final data = await repository.fetchKpiData(event.page, pageSize);
        
        // Cek apakah data yang datang kurang dari pageSize, berarti sudah habis
        bool reachedMax = data.length < pageSize;
        
        emit(KpiLoaded(
          data: data, 
          currentPage: event.page, 
          hasReachedMax: reachedMax
        ));
      } catch (e) {
        emit(KpiError("Gagal memuat data dashboard."));
      }
    });
  }
}