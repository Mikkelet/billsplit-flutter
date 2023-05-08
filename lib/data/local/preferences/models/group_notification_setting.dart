import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_notification_setting.g.dart';

@JsonSerializable()
class GroupNotificationSetting {
  final String groupId;
  bool addExpenseSetting;
  bool updateExpenseSetting;
  bool newServiceSetting;

  GroupNotificationSetting(this.addExpenseSetting, this.updateExpenseSetting,
      this.newServiceSetting, this.groupId);

  GroupNotificationSetting.fromNewGroup(this.groupId)
      : addExpenseSetting = true,
        newServiceSetting = true,
        updateExpenseSetting = true;

  factory GroupNotificationSetting.fromJson(Json json) =>
      _$GroupNotificationSettingFromJson(json);

  Json toJson() => _$GroupNotificationSettingToJson(this);
}
