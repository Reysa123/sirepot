import 'package:sirepot/model/service_reminder.dart';

abstract class KpiState {}

class KpiInitial extends KpiState {}

class KpiLoading extends KpiState {}

class KpiLoaded extends KpiState {
  final List<ServiceReminder> data;
  final int currentPage;
  final List<String> month;
  final List<String> repair;
  final List<String> program;
  final List<String> sbe;
  final bool hasReachedMax;

  KpiLoaded({
    required this.data,
    required this.sbe,
    required this.month,
    required this.repair,
    required this.program,
    this.currentPage = 0,
    this.hasReachedMax = false,
  });
}

class KpiError extends KpiState {
  final String message;
  KpiError(this.message);
}
