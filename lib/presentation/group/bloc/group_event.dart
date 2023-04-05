abstract class GroupEvent {}

class LoadGroup extends GroupEvent {}
class NavigateTo extends GroupEvent {
  final int index;
  NavigateTo(this.index);
}