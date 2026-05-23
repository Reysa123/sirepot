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
  final String? selectedSbe;
  final String? selectedMonth;
  final String? selectedRepair;
  final String? selectedProgram;
  KpiLoaded({
    required this.data,
    required this.sbe,
    required this.month,
    required this.repair,
    required this.program,
    this.currentPage = 0,
    this.hasReachedMax = false,
    this.selectedSbe,
    this.selectedMonth,
    this.selectedRepair,
    this.selectedProgram,
  });

  KpiLoaded copyWith({
    List<String>? sbe,
    List<String>? month,
    List<String>? repair,
    List<String>? program,
    List<ServiceReminder>? data,
    String? selectedSbe,
    String? selectedMonth,
    String? selectedRepair,
    String? selectedProgram,
  }) {
    return KpiLoaded(
      sbe: sbe ?? this.sbe,
      month: month ?? this.month,
      repair: repair ?? this.repair,
      program: program ?? this.program,
      data: data ?? this.data,
      selectedSbe: selectedSbe ?? this.selectedSbe,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      selectedRepair: selectedRepair ?? this.selectedRepair,
      selectedProgram: selectedProgram ?? this.selectedProgram,
    );
  }
}

class KpiError extends KpiState {
  final String message;
  KpiError(this.message);
}
