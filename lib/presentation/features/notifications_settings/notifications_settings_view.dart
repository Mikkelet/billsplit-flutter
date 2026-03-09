import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/features/notifications_settings/bloc/notification_settings_cubit.dart';
import 'package:billsplit_flutter/presentation/features/notifications_settings/widgets/notification_setting_view.dart';
import 'package:billsplit_flutter/presentation/features/notifications_settings/bloc/notification_topics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsSettingsView extends StatelessWidget {
  const NotificationsSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationSettingsCubit, NotificationsSettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Notification settings"),
            leading: const BackButton(),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16),
              child: RoundedListItem(
                child: Column(
                  children: NotificationTopic.values
                      .map((topic) => NotificationSettingView(topic, isSubscribed: true))
                      .toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
