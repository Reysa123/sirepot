abstract class KpiEvent {}

class FetchKpiData extends KpiEvent {
  final int page;
  FetchKpiData({this.page = 0});
}

class SearchKpiData extends KpiEvent {
  final String query;
  SearchKpiData(this.query);
}