import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/data/remote/network_client.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/friend.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/phone_number.dart';
import 'package:billsplit_flutter/domain/repositories/auth_repository.dart';
import 'package:billsplit_flutter/domain/use_cases/auth/sign_out_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/friends/observe_friends_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/group_invites/observe_group_invites_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/profile/parse_phonenumber_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/profile/update_display_name_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/safe_cubit.dart';
import 'package:billsplit_flutter/presentation/features/profile/bloc/profile_state.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rxdart/rxdart.dart';

class ProfileCubit extends SafeCubit<ProfileState> {
  final _signOutUseCase = SignOutUseCase();
  final _updateDisplayNameUseCase = UpdateDisplayNameUseCase();
  final _parseUsePhoneNumberUseCase = ParsePhoneNumberUseCase();
  final _observeFriendsUseCase = ObserveFriendsUseCase();
  final _observeGroupInvitesUseCase = ObserveGroupInvitesUseCase();
  final compositeSubscription = CompositeSubscription();
  final authRepository = getIt<AuthRepository>();
  final sharedPrefs = getIt<SharedPrefs>();

  ProfileCubit() : super(const ProfileState()) {
    init();
  }

  bool get showProfileInfo => !authRepository.loggedInUser.isGuest;

  Person get user => authRepository.loggedInUser;


  void init() {
    _observeNotifications();
    _syncVersion();
  }

  void _observeNotifications() {
    _observeFriendsUseCase
        .observe()
        .listen((event) {
          final invites =
              event.where((element) => element.status == FriendStatus.requestReceived).length;
          safeEmit(state.copyWith(friendInvites: invites));
        })
        .addTo(compositeSubscription);

    _observeGroupInvitesUseCase
        .observe()
        .listen((event) {
          safeEmit(state.copyWith(groupInvites: event.length));
        })
        .addTo(compositeSubscription);
  }

  void signOut() async {
    try {
      safeEmit(state.copyWith(isLoading: true));
      await _signOutUseCase.launch();
    } catch (e, st) {
      logError(e, st);
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  void updateDisplayName(String newName) async {
    try {
      await _updateDisplayNameUseCase.launch(newName);
    } catch (e, st) {
      logError(e, st);
    } finally {
      safeEmit(state.copyWith(event: ProfileStateEvents.none));
    }
  }

  void updateCurrency(Currency currency) {
    sharedPrefs.userPrefDefaultCurrency = currency.symbol;
  }

  void _syncVersion() async {
    PackageInfo.fromPlatform().then((packageInfo) {
      const apiVersion = NetworkClient.apiVersion;
      final appVersion = packageInfo.buildNumber;
      safeEmit(
        state.copyWith(
          version: "Version ${packageInfo.version} ($appVersion), apiVersion $apiVersion",
        ),
      );
    });
  }

  Future<PhoneNumber?> getPhoneNumber() async {
    final user = authRepository.loggedInUser;
    final phoneNumber = await _parseUsePhoneNumberUseCase.launch(user.phoneNumberState.value.dial);
    return phoneNumber;
  }

  void onDeleteUserPressed() {
    safeEmit(state.copyWith(event: ProfileStateEvents.showDeleteUser));
  }
}
