
abstract class Cr7Event {}

class FetchCr7Data extends Cr7Event {
  final int page;
   FetchCr7Data({this.page = 0});
}

class SearchCr7Data extends Cr7Event {
  final String query;
  SearchCr7Data(this.query);
}


