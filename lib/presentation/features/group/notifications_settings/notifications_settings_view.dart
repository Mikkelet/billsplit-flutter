import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/features/group/notifications_settings/notification_setting_view.dart';
import 'package:billsplit_flutter/presentation/features/group/notifications_settings/notification_topics.dart';
import 'package:flutter/material.dart';

class NotificationsSettingsView extends StatelessWidget {
  final Group group;

  const NotificationsSettingsView({Key? key, required this.group})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification settings"),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16),
          child: RoundedListItem(
            padding: 16,
            child: Column(
              children: [
                ...NotificationTopic.values
                    .map((topic) => NotificationSettingView(group, topic))
              ],
            ),
          ),
        ),
      ),
    );
  }

  static getRoute(Group group) => MaterialPageRoute(
      builder: (context) => NotificationsSettingsView(group: group));
}
