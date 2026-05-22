import 'package:sirepot/model/service_reminder.dart';

abstract class SpesialOrderPartState {}

class SpesialOrderPartInitial extends SpesialOrderPartState {}

class SpesialOrderPartLoading extends SpesialOrderPartState {}

class SpesialOrderPartLoaded extends SpesialOrderPartState {
  final List<SpesialOrderPart> data;
  final int currentPage;
  final List<String> sa;
  final List<String> sales;
  final List<String> vin;
  final List<String> model;
  final bool hasReachedMax;

  SpesialOrderPartLoaded({
    required this.data,
    required this.sa,
    required this.sales,
    required this.vin,
    required this.model,
    this.currentPage = 0,
    this.hasReachedMax = false,
  });
}

class SpesialOrderPartError extends SpesialOrderPartState {
  final String message;
  SpesialOrderPartError(this.message);
}
