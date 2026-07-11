abstract class KpiEvent {}

class FetchKpiData extends KpiEvent {
  final int page;
  final List<String>? listPetugas;
  final String? repair;
  final String? sbe;
  final String? program;
  final String? month;
  final String? nopol;
  final String? area;
  final bool reload;
  FetchKpiData({
    this.page = 0,
    this.listPetugas,
    this.repair,
    this.sbe,
    this.program,
    this.month,
    this.nopol,
    this.area,
    this.reload = false,
  });
}

class FilterKpiData extends KpiEvent {
  final String? repair;
  final String? sbe;
  final String? program;
  final String? month;
  final String? nopol;
  final String? area;
  final bool reload;

  FilterKpiData({
    this.repair,
    this.sbe,
    this.program,
    this.month,
    this.nopol,
    this.area,
    this.reload = false,
  });
}

class SearchKpiData extends KpiEvent {
  final String query;
  SearchKpiData(this.query);
}
