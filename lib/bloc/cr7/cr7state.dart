import 'package:sirepot/model/service_reminder.dart';

abstract class Cr7State {}

class Cr7Initial extends Cr7State {}

class Cr7Loading extends Cr7State {}

class Cr7Loaded extends Cr7State {
  final List<CR7> data;
  final List<String> listPetugas;
  final int currentPage;
  final List<String> sa;
  final List<String> month;
  final bool hasReachedMax;
  final String? selectedSa;
  final String? selectedMonth;
  final String? selectedNopol;
  Cr7Loaded({
    required this.listPetugas,
    required this.data,
    required this.sa,
    required this.month,
    this.currentPage = 0,
    this.hasReachedMax = false,
    this.selectedSa,
    this.selectedMonth,
    this.selectedNopol,
  });
  Cr7Loaded copyWith({
    List<String>? sa,
    List<String>? listPetugas,
    List<String>? month,
    List<CR7>? data,
    String? selectedSa,
    String? selectedMonth,
    String? selectedNopol,
  }) {
    return Cr7Loaded(
      listPetugas: listPetugas??this.listPetugas,
      sa: sa ?? this.sa,
      month: month ?? this.month,
      data: data ?? this.data,
      selectedSa: selectedSa ?? this.selectedSa,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      selectedNopol: selectedNopol ?? this.selectedNopol,
    );
  }
}

class Cr7Error extends Cr7State {
  final String message;
  Cr7Error(this.message);
}
