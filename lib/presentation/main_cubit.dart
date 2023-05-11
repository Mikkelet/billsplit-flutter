import 'dart:async';
import 'dart:io';

import 'package:billsplit_flutter/domain/use_cases/get_fcm_token_permission.dart';
import 'package:billsplit_flutter/domain/use_cases/get_local_group_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_auth_state_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/domain/use_cases/initialize_auth_usecase.dart';
import 'package:billsplit_flutter/presentation/main_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';

import 'base/bloc/base_state.dart';

class MainCubit extends BaseCubit {
  final _observeAuthStateUseCase = ObserveAuthStateUseCase();
  final _initializeAuthUseCase = InitializeAuthUseCase();
  final _getFCMTokenPermission = GetNotificationPermission();
  final _getGroupUseCase = GetLocalGroupUseCase();

  StreamSubscription? _fcmTokenDisposable;
  StreamSubscription? _onMessageOpenedDisposable;

  MainCubit() : super.withState(Loading());

  Stream<String?> observeAuthState() {
    return _observeAuthStateUseCase.observe().doOnData((auth) {
      if (auth != null) {
        FirebaseMessaging.instance.subscribeToTopic("user-$auth");
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
    }, onError: (error) {
      showError(error);
    });
  }

  void _initialiseAuth() {
    _initializeAuthUseCase.initialize().then((value) {
      emit(Main());
    }).catchError((err) {
      showError(err);
    });
  }

  @override
  Future<void> close() {
    _fcmTokenDisposable?.cancel();
    _onMessageOpenedDisposable?.cancel();
    return super.close();
  }
}
