
abstract class SpesialOrderPartEvent {}

class FetchSpesialOrderPartData extends SpesialOrderPartEvent {
  final int page;
   FetchSpesialOrderPartData({this.page = 0});
}

class SearchSpesialOrderPartData extends SpesialOrderPartEvent {
  final String query;
  SearchSpesialOrderPartData(this.query);
}


