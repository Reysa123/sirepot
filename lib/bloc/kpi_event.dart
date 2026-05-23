
abstract class KpiEvent {}

class FetchKpiData extends KpiEvent {
  final int page;
   FetchKpiData({this.page = 0});
}
class FilterKpiData extends KpiEvent {
  final String? repair;
  final String? sbe;
  final String? program;
  final String? month;

  FilterKpiData({this.repair, this.sbe, this.program, this.month});
}
class SearchKpiData extends KpiEvent {
  final String query;
  SearchKpiData(this.query);
}


