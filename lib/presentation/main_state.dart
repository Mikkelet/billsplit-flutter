import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';

class ShowNotificationPermission extends Main{}

class GroupOpenedFromNotification extends Main{
  final Group group;
  GroupOpenedFromNotification(this.group);

}