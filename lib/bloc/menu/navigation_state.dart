import 'package:flutter/material.dart';

abstract class NavigationState {}

class NavigationStates extends NavigationState {
  int selectedIndex = 0;
  final List<ImageProvider> image;
  NavigationStates(this.selectedIndex, this.image);
}

class NaviNull extends NavigationState {
  int selectedIndex = 0;
  NaviNull(this.selectedIndex);
}

class Loading extends NavigationState {}
