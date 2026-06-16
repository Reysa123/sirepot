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
  final String? selectedSa;
  final String? selectedSales;
  final String? selectedVin;
  final String? selectedModel;
  final String? selectedNopol;
  SpesialOrderPartLoaded({
    required this.data,
    required this.sa,
    required this.sales,
    required this.vin,
    required this.model,
    this.currentPage = 0,
    this.hasReachedMax = false,
    this.selectedSa,
    this.selectedSales,
    this.selectedVin,
    this.selectedModel,
     this.selectedNopol,

  });
  SpesialOrderPartLoaded copyWith({
    List<String>? sa,
    List<String>? sales,
    List<String>? vin,
    List<String>? model,
    List<SpesialOrderPart>? data,
    String? selectedSa,
    String? selectedSales,
    String? selectedVin,
    String? selectedModel,
     String? selectedNopol,
  }) {
    return SpesialOrderPartLoaded(
      sa: sa ?? this.sa,
      sales: sales ?? this.sales,
      vin: vin ?? this.vin,
      model: model ?? this.model,
      data: data ?? this.data,
      selectedSa: selectedSa ?? this.selectedSa,
      selectedSales: selectedSales ?? this.selectedSales,
      selectedVin: selectedVin ?? this.selectedVin,
      selectedModel: selectedModel ?? this.selectedModel,
      selectedNopol: selectedNopol ?? this.selectedNopol,
    );
  }
}

class SpesialOrderPartError extends SpesialOrderPartState {
  final String message;
  SpesialOrderPartError(this.message);
}
