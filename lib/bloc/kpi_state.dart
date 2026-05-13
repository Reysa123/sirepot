import 'package:sirepot/model/service_reminder.dart';

abstract class KpiState {}

class KpiInitial extends KpiState {}

class KpiLoading extends KpiState {}

class KpiLoaded extends KpiState {
  final List<ServiceReminder> data;
  final int currentPage;
  final bool hasReachedMax;

  KpiLoaded({
    required this.data, 
    this.currentPage = 0, 
    this.hasReachedMax = false
  });
}

class KpiError extends KpiState {
  final String message;
  KpiError(this.message);
}