abstract class NavigationEvent {}

class ChangeMenuEvent extends NavigationEvent {
  final int index;
  ChangeMenuEvent(this.index);
}