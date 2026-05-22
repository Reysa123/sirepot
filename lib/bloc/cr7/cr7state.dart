
import 'package:sirepot/model/service_reminder.dart';

abstract class Cr7State {}

class Cr7Initial extends Cr7State {}

class Cr7Loading extends Cr7State {}

class Cr7Loaded extends Cr7State {
  final List<CR7> data;
  final int currentPage;

  final bool hasReachedMax;

  Cr7Loaded({
    required this.data,
    this.currentPage = 0,
    this.hasReachedMax = false,
  });
}



class Cr7Error extends Cr7State {
  final String message;
  Cr7Error(this.message);
}
