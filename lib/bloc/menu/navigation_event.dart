abstract class NavigationEvent {}

class ChangeMenuEvent extends NavigationEvent {
  int index = 0;
  ChangeMenuEvent(this.index);
}

class LoadingMenu extends NavigationEvent {}
