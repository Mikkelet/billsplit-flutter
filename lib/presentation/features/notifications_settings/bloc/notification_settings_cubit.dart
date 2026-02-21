import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/use_cases/subscribe_to_topic_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/safe_cubit.dart';
import 'package:billsplit_flutter/presentation/features/notifications_settings/bloc/notification_topics.dart';
import 'package:collection/collection.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../_generated/presentation/features/notifications_settings/bloc/notification_settings_cubit.freezed.dart';

class NotificationSettingsCubit extends SafeCubit<NotificationsSettingsState> {
  final _toggleSubscriptionUseCase = ToggleTopicSubscriptionUseCase();
  final SharedPrefs _sharedPrefs;
  final NotificationTopic topic;
  final Group group;

  NotificationSettingsCubit(this._sharedPrefs, this.topic, this.group)
    : super(NotificationsSettingsState());

  void initialise() {
    final settings = _sharedPrefs.groupNotificationSettings.firstWhereOrNull(
      (element) => element.groupId == group.id,
    );
    if (settings != null) {
      safeEmit(state.copyWith(isSubscribed: true));
    }
  }

  void onSubscribeToTopic(bool subscribe) async {
    try {
      safeEmit(state.copyWith(isLoading: true));
      await _toggleSubscriptionUseCase.launch(group.id, topic, subscribe);
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }
}

@freezed
abstract class NotificationsSettingsState with _$NotificationsSettingsState {
  const factory NotificationsSettingsState({
    @Default(false) bool isLoading,
    @Default(false) bool isSubscribed,
    @Default(SplitsbyError.none()) SplitsbyError error,
  }) = _NotificationsSettingsState;
}
