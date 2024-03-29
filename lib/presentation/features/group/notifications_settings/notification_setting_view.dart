import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/features/group/notifications_settings/notification_settings_cubit.dart';
import 'package:billsplit_flutter/presentation/features/group/notifications_settings/notification_topics.dart';
import 'package:flutter/material.dart';

class NotificationSettingView extends StatelessWidget {
  final Group group;
  final NotificationTopic topic;

  const NotificationSettingView(this.group, this.topic, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget<NotificationSettingsCubit>(
      create: (context) =>
          NotificationSettingsCubit(topic, group)..initialise(),
      child: BaseBlocBuilder<NotificationSettingsCubit>(
        builder: (cubit, state) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(topic.getTopicName(), style: Theme.of(context).textTheme.labelSmall,),
              if (state is Main)
                Checkbox(
                    fillColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Theme.of(context).colorScheme.inversePrimary;
                      }
                      return Theme.of(context).colorScheme.secondaryContainer;
                    }),
                    value: cubit.isSubscribed,
                    onChanged: (value) {
                      if (value == null) return;
                      cubit.onSubscribeToTopic(value);
                    }),
              if (state is Loading) const CircularProgressIndicator(),
            ],
          );
        },
      ),
    );
  }
}
