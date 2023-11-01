import 'dart:async';
import 'dart:io';

import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/domain/use_cases/app_data/get_app_version.dart';
import 'package:billsplit_flutter/domain/use_cases/permissions/get_fcm_token_permission.dart';
import 'package:billsplit_flutter/domain/use_cases/groups/get_local_group_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/auth/observe_auth_state_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/domain/use_cases/auth/initialize_auth_usecase.dart';
import 'package:billsplit_flutter/presentation/main_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';

import 'base/bloc/base_state.dart';

class MainCubit extends BaseCubit {
  final _observeAuthStateUseCase = ObserveAuthStateUseCase();
  final _initializeAuthUseCase = InitializeAuthUseCase();
  final _getFCMTokenPermission = GetNotificationPermission();
  final _getGroupUseCase = GetLocalGroupUseCase();
  final _getAppVersion = GetAppVersion();

  StreamSubscription? _fcmTokenDisposable;
  StreamSubscription? _onMessageOpenedDisposable;

  MainCubit() : super.withState(Loading());

  Stream<AuthState> observeAuthState() {
    return _observeAuthStateUseCase.observe().doOnData((authState) {
      if (authState is LoggedInState) {
        final userId = authState.user;
        FirebaseMessaging.instance.subscribeToTopic("user-$userId");
        initializePushNotification();
      }
    });
  }

  void initialize() {
    showLoading();
    _initialiseAuth();
    _initialiseOnMessageOpened();
  }

  void initializePushNotification() {
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
      if (Platform.isAndroid) {
        if (event.from?.startsWith("/topics/group") == true) {
          final groupId = event.data["groupId"];
          final group = await _getGroupUseCase.launch(groupId);
          emit(GroupOpenedFromNotification(group));
        }
      } else {
        final String? groupId = event.data["groupId"];
        if (groupId != null) {
          final group = await _getGroupUseCase.launch(groupId);
          emit(GroupOpenedFromNotification(group));
        }
      }
    }, onError: (error, st) {
      showError(error, st);
    });
  }

  void checkAppVersion() {
    Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      _getAppVersion.launch().then((appVersion) {
        if (appVersion.mandatoryUpdateAvailable) {
          emit(MandatoryUpdateState(appVersion));
        }
      }).catchError((err, stackTrace) {
        showError(err, stackTrace);
      });
    });
  }

  @override
  void emit(UiState state) {
    if (this.state is MandatoryUpdateState) return;
    super.emit(state);
  }

  void _initialiseAuth() {
    _initializeAuthUseCase.initialize().then((value) {
      emit(Main());
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
