import 'package:flutter/material.dart';

abstract class KpiEvent {}

class FetchKpiData extends KpiEvent {
  final int page;
   final Widget widget;
   FetchKpiData({this.page = 0,this.widget=const SizedBox()});
}

class SearchKpiData extends KpiEvent {
  final String query;
  SearchKpiData(this.query);
}


