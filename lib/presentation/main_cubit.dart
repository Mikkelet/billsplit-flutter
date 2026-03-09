import 'dart:async';

import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/domain/repositories/auth_repository.dart';
import 'package:billsplit_flutter/domain/repositories/auth_state.dart';
import 'package:billsplit_flutter/domain/use_cases/app_data/get_app_version.dart';
import 'package:billsplit_flutter/domain/use_cases/auth/initialize_auth_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/notifications/handle_on_message_open_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/permissions/get_fcm_token_permission.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/safe_cubit.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:billsplit_flutter/presentation/main_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';

import 'base/bloc/base_state.dart';

class MainCubit extends SafeCubit<MainState> {
  final _initializeAuthUseCase = InitializeAuthUseCase();
  final _getFCMTokenPermission = GetNotificationPermission();
  final _getAppVersion = GetAppVersion();
  final _handleOnMessageOpenUseCase = HandleOnMessageOpenedUseCase();
  final SharedPrefs _sharedPrefs;

  MainCubit(this._sharedPrefs) : super(const MainState());

  Future<void> initialize() async {
    try {
      safeEmit(state.copyWith(isLoading: true));
      await _initialiseAuth();
      _initialiseOnMessageOpened();
      checkAppVersion();
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.unknown(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  void _initializePushNotification() {
    _getFCMTokenPermission.launch();
  }

  void _initialiseOnMessageOpened() {
    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      final action = await _handleOnMessageOpenUseCase.launch(event.data);
      if (action != null) {

      }
    });
  }

  void checkAppVersion() async {
    try {
      final version = await _getAppVersion.launch();
      if (version.mandatoryUpdateAvailable) {
        await Future.delayed(const Duration(seconds: 1));
      }
    } catch (e, st) {
      logError(e, st);
    }
  }

  Future<void> _initialiseAuth() async {
    try {
      await _initializeAuthUseCase.initialize();
    } catch (e, st) {
      logError(e, st);
    }
  }
}
