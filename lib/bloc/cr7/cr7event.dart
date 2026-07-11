abstract class Cr7Event {}

class FetchCr7Data extends Cr7Event {
  final int page;
  FetchCr7Data({this.page = 0});
}

class FilterCr7Data extends Cr7Event {
  final String? sa;
  final String? month;
  final String? nopol;

  FilterCr7Data({this.sa, this.month,this.nopol});
}

class SearchCr7Data extends Cr7Event {
  final String query;
  SearchCr7Data(this.query);
}
