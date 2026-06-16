abstract class NavigationState {}
class NavigationStates extends NavigationState {
  final int selectedIndex;
  NavigationStates(this.selectedIndex);
}
class Loading extends NavigationState{}