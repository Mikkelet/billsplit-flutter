// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/local/preferences/models/group_notification_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupNotificationSetting _$GroupNotificationSettingFromJson(
        Map<String, dynamic> json) =>
    GroupNotificationSetting(
      json['addExpenseSetting'] as bool,
      json['updateExpenseSetting'] as bool,
      json['newServiceSetting'] as bool,
      json['groupId'] as String,
    );

Map<String, dynamic> _$GroupNotificationSettingToJson(
        GroupNotificationSetting instance) =>
    <String, dynamic>{
      'groupId': instance.groupId,
      'addExpenseSetting': instance.addExpenseSetting,
      'updateExpenseSetting': instance.updateExpenseSetting,
      'newServiceSetting': instance.newServiceSetting,
    };
