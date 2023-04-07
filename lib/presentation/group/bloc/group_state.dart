import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';

abstract class GroupState {}

class GroupLoaded extends GroupState {
  final Group group;
  final List<Event> events;
  final List<SubscriptionService> services;
  final int navIndex;
  GroupLoaded(this.group, this.events, this.navIndex, this.services);
}
class Loading extends GroupState {}
class LoadingFailed extends GroupState {

}

