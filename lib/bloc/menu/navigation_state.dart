// Update NavigationState.dart
import 'package:flutter/material.dart';

abstract class NavigationState {
  // Tambahkan list image di sini agar semua state bisa mengaksesnya
  final List<ImageProvider> images;
  NavigationState(this.images);
}

class NavigationStates extends NavigationState {
  NavigationStates(super.images);
}

class NaviNull extends NavigationState {
  final int selectedIndex;
  // NaviNull sekarang membawa data images dari parent
  NaviNull(this.selectedIndex, List<ImageProvider> images) : super(images);
}

class Loading extends NavigationState {
  Loading() : super([]);
}
