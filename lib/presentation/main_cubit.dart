import 'dart:async';

import 'package:billsplit_flutter/domain/repositories/auth_state.dart';
import 'package:billsplit_flutter/domain/use_cases/app_data/get_app_version.dart';
import 'package:billsplit_flutter/domain/use_cases/notifications/handle_on_message_open_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/permissions/get_fcm_token_permission.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/domain/use_cases/auth/initialize_auth_usecase.dart';
import 'package:billsplit_flutter/presentation/main_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'base/bloc/base_state.dart';

class MainCubit extends BaseCubit {
  final _initializeAuthUseCase = InitializeAuthUseCase();
  final _getFCMTokenPermission = GetNotificationPermission();
  final _getAppVersion = GetAppVersion();
  final _handleOnMessageOpenUseCase = HandleOnMessageOpenedUseCase();

  StreamSubscription? _fcmTokenDisposable;
  StreamSubscription? _onMessageOpenedDisposable;

  int notificationsCounter = 0;

  MainCubit() : super.withState(Loading());

  Stream<AuthState> observeAuthState() {
    return authRepository.observeAuthState().map((authState) {
      if (authState is LoggedInState) {
        _initializePushNotification();
      }
      return authState;
    }).handleError((err) {
      showToast("$err");
    });
  }

  void initialize() {
    showLoading();
    _initialiseAuth();
    _initialiseOnMessageOpened();
    checkAppVersion();
  }

  void _initializePushNotification() {
    _getFCMTokenPermission.launch().then((permissionState) {
      final hasSeenRationale =
          sharedPrefs.hasSeenPushNotificationPermissionRationale;
      final showRationale = !hasSeenRationale &&
          (permissionState == AuthorizationStatus.notDetermined ||
              permissionState == AuthorizationStatus.denied);
      if (showRationale) emit(ShowNotificationPermissionRationale());
    });
  }

  void _initialiseOnMessageOpened() {
    _onMessageOpenedDisposable =
        FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      final action = await _handleOnMessageOpenUseCase.launch(event.data);
      if (action != null) {
        emit(NotificationActionEvent(notificationAction: action));
      }
    }, onError: (error, st) {
      showError(error, st);
    });
  }

  void checkAppVersion() {
    _getAppVersion.launch().then((appVersion) {
      if (appVersion.mandatoryUpdateAvailable) {
        Future.delayed(const Duration(seconds: 1)).whenComplete(() {
          emit(MandatoryUpdateState(appVersion));
        });
      }
    }).catchError((err, stackTrace) {
      showError(err, stackTrace);
    });
  }

  @override
  void emit(UiState state) {
    if (this.state is MandatoryUpdateState) return;
    super.emit(state);
  }

  void _initialiseAuth() {
    _initializeAuthUseCase.initialize().then((value) {
      update();
    }).catchError((err, st) {
      showError(err, st);
    });
  }

  @override
  Future<void> close() {
    _fcmTokenDisposable?.cancel();
    _onMessageOpenedDisposable?.cancel();
    return super.close();
  }
}
