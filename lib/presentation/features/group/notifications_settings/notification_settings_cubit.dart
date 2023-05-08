import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/use_cases/subscribe_to_topic_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/features/group/notifications_settings/notification_topics.dart';

class NotificationSettingsCubit extends BaseCubit {
  final _toggleSubscriptionUseCase = ToggleTopicSubscriptionUseCase();
  final NotificationTopic _topic;
  final Group _group;
  late bool isSubscribed;

  NotificationSettingsCubit(this._topic, this._group);

  void initialise() {
    final settings = sharedPrefs.groupNotificationSettings
        .firstWhere((element) => element.groupId == _group.id);
    isSubscribed = _topic.getSetting(settings);
    emit(Main());
  }

  void onSubscribeToTopic(bool subscribe) {
    showLoading();
    _toggleSubscriptionUseCase.launch(_group.id, _topic, subscribe).then((_) {
      isSubscribed = subscribe;
      emit(Main());
    }).catchError((error) {
      showError(error);
    });
  }
}
