import 'package:billsplit_flutter/data/remote/network_client.dart';
import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/friend.dart';
import 'package:billsplit_flutter/domain/models/phone_number.dart';
import 'package:billsplit_flutter/domain/use_cases/auth/sign_out_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/friends/observe_friends_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/group_invites/observe_group_invites_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/profile/parse_phonenumber_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/profile/update_display_name_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/features/profile/bloc/profile_state.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rxdart/rxdart.dart';

class ProfileCubit extends BaseCubit {
  final _signOutUseCase = SignOutUseCase();
  final _updateDisplayNameUseCase = UpdateDisplayNameUseCase();
  final _parseUsePhoneNumberUseCase = ParsePhoneNumberUseCase();
  final _observeFriendsUseCase = ObserveFriendsUseCase();
  final _observeGroupInvitesUseCase = ObserveGroupInvitesUseCase();

  final friendsCounter = 0.obs();
  final groupInvitesCounter = 0.obs();
  final appVersionState = "".obs();

  bool get showProfileInfo => !user.isGuest;

  void loadNotifications() async {
    await _observeNotifications();
    _syncVersion();
  }

  Future _observeNotifications() async {
    _observeFriendsUseCase.observe().listen((event) {
      friendsCounter.value = event
          .where((element) => element.status == FriendStatus.requestReceived)
          .length;
    }).addTo(compositeSubscription);

    _observeGroupInvitesUseCase.observe().listen((event) {
      groupInvitesCounter.value = event.length;
    }).addTo(compositeSubscription);
  }

  void signOut() {
    showLoading();
    _signOutUseCase.launch().then((value) {}).catchError((error, st) {
      showError(error, st);
    });
  }

  void updateDisplayName(String newName) async {
    emit(SubmittingEditName());
    _updateDisplayNameUseCase.launch(newName).then((value) {
      update();
    }).catchError((err, stackTrace) {
      showError(err, stackTrace);
    });
  }

  void updateCurrency(Currency currency) {
    sharedPrefs.userPrefDefaultCurrency = currency.symbol;
    update();
  }

  void _syncVersion() async {
    PackageInfo.fromPlatform().then((packageInfo) {
      const apiVersion = NetworkClient.apiVersion;
      final appVersion = packageInfo.buildNumber;
      appVersionState.value =
          "Version ${packageInfo.version} ($appVersion), apiVersion $apiVersion";
    });
  }

  Future<PhoneNumber?> getPhoneNumber() async {
    final phoneNumber = await _parseUsePhoneNumberUseCase
        .launch(user.phoneNumberState.value.dial);
    return phoneNumber;
  }

  void onDeleteUserPressed() {
    emit(ShowDeleteUser());
  }
}
