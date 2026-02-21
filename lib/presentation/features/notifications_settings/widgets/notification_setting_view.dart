import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/features/notifications_settings/bloc/notification_settings_cubit.dart';
import 'package:billsplit_flutter/presentation/features/notifications_settings/bloc/notification_topics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationSettingView extends StatelessWidget {
  final NotificationTopic topic;
  final bool isSubscribed;

  const NotificationSettingView(this.topic, {super.key, required this.isSubscribed});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NotificationSettingsCubit>();
    return BlocBuilder<NotificationSettingsCubit, NotificationsSettingsState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              topic.getTopicName(),
              style: Theme.of(context).textTheme.labelSmall,
            ),
            if (state is Main)
              Checkbox(
                fillColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Theme.of(context).colorScheme.inversePrimary;
                  }
                  return Theme.of(context).colorScheme.secondaryContainer;
                }),
                value: isSubscribed,
                onChanged: (value) {
                  if (value == null) return;
                  cubit.onSubscribeToTopic(value);
                },
              ),
            if (state is Loading) const CircularProgressIndicator(),
          ],
        );
      },
    );
  }
}
