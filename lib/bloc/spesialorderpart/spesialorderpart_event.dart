abstract class SpesialOrderPartEvent {}

class FetchSpesialOrderPartData extends SpesialOrderPartEvent {
  final int page;
  FetchSpesialOrderPartData({this.page = 0});
}

class FilterSpesialOrderPartData extends SpesialOrderPartEvent {
  final String? sa;
  final String? sales;
  final String? vin;
  final String? model;
  final String? nopol;
  FilterSpesialOrderPartData({this.sa, this.sales, this.vin, this.model,this.nopol});
}

class SearchSpesialOrderPartData extends SpesialOrderPartEvent {
  final String query;
  SearchSpesialOrderPartData(this.query);
}
