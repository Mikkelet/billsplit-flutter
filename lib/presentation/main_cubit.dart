import 'dart:async';

import 'package:billsplit_flutter/domain/repositories/auth_state.dart';
import 'package:billsplit_flutter/domain/use_cases/app_data/get_app_version.dart';
import 'package:billsplit_flutter/domain/use_cases/auth/initialize_auth_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/notifications/handle_on_message_open_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/permissions/get_fcm_token_permission.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/main_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';

import 'base/bloc/base_state.dart';

class MainCubit extends BaseCubit {
  final _initializeAuthUseCase = InitializeAuthUseCase();
  final _getFCMTokenPermission = GetNotificationPermission();
  final _getAppVersion = GetAppVersion();
  final _handleOnMessageOpenUseCase = HandleOnMessageOpenedUseCase();

  MainCubit() : super.withState(Loading());

  Stream<AuthState> observeAuthState() {
    return authRepository
        .observeAuthState()
        .map((authState) {
          if (authState is LoggedInState) {
            _initializePushNotification();
          }
          return authState;
        })
        .handleError((err) {
          showToast("$err");
        });
  }

  Future<void> initialize() async {
    showLoading();
    await _initialiseAuth();
    _initialiseOnMessageOpened();
    checkAppVersion();
  }

  void _initializePushNotification() {
    _getFCMTokenPermission.launch().then((permissionState) {
      final hasSeenRationale =
          sharedPrefs.hasSeenPushNotificationPermissionRationale;
      final showRationale =
          !hasSeenRationale &&
          (permissionState == AuthorizationStatus.notDetermined ||
              permissionState == AuthorizationStatus.denied);
      if (showRationale) emit(ShowNotificationPermissionRationale());
    });
  }

  void _initialiseOnMessageOpened() {
    FirebaseMessaging.onMessageOpenedApp
        .listen(
          (event) async {
            final action = await _handleOnMessageOpenUseCase.launch(event.data);
            if (action != null) {
              emit(NotificationActionEvent(notificationAction: action));
            }
          },
          onError: (error, st) {
            showError(error, st);
          },
        )
        .addTo(compositeSubscription);
  }

  void checkAppVersion() async {
    try {
      final version = await _getAppVersion.launch();
      if (version.mandatoryUpdateAvailable) {
        await Future.delayed(const Duration(seconds: 1));
        emit(MandatoryUpdateState(version));
      }
    } catch (e, st) {
      showError(e, st);
    }
  }

  @override
  void emit(UiState state) {
    if (this.state is MandatoryUpdateState) return;
    super.emit(state);
  }

  Future<void> _initialiseAuth() async {
    try {
      await _initializeAuthUseCase.initialize();
      update();
      emit(Main());
    } catch (e, st) {
      showError(e, st);
    }
  }
}
