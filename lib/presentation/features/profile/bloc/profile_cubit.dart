import 'package:billsplit_flutter/data/remote/network_client.dart';
import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/friend.dart';
import 'package:billsplit_flutter/domain/models/phone_number.dart';
import 'package:billsplit_flutter/domain/use_cases/friends/observe_friends_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/group_invites/observe_group_invites_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/profile/parse_phonenumber_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/profile/update_display_name_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/susi/sign_out_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/features/profile/bloc/profile_state.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfileCubit extends BaseCubit {
  final _signOutUseCase = SignOutUseCase();
  final _updateDisplayNameUseCase = UpdateDisplayNameUseCase();
  final _parseUsePhoneNumberUseCase = ParsePhoneNumberUseCase();
  final _observeFriendsUseCase = ObserveFriendsUseCase();
  final _observeGroupInvitesUseCase = ObserveGroupInvitesUseCase();

  int friendsCounter = 0;
  int groupInvitesCounter = 0;

  void loadNotifications() async {
    await _updateFriendsCounter();
    await _updateGroupInvitesCounter();
    update();
  }

  Future _updateFriendsCounter() async {
    final friends = await _observeFriendsUseCase.observe().first;
    final requests = friends
        .where((element) => element.status == FriendStatus.requestReceived);
    friendsCounter = requests.length;
  }

  Future _updateGroupInvitesCounter() async {
    final invites = await _observeGroupInvitesUseCase.observe().first;
    groupInvitesCounter = invites.length;
  }

  void signOut() {
    showLoading();
    _signOutUseCase.launch().then((value) {}).catchError((error, st) {
      showError(error, st);
    });
  }

  Future updateDisplayName(String newName) async {
    await _updateDisplayNameUseCase.launch(newName);
    update();
  }

  void updateCurrency(Currency currency) {
    sharedPrefs.userPrefDefaultCurrency = currency.symbol;
    emit(Main());
  }

  Future<String> syncVersion() async {
    const apiVersion = NetworkClient.apiVersion;
    final packageInfo = await PackageInfo.fromPlatform();
    final appVersion = packageInfo.buildNumber;
    return "Version ${packageInfo.version} ($appVersion), apiVersion $apiVersion";
  }

  Future<PhoneNumber?> getPhoneNumber() async {
    final phoneNumber =
        await _parseUsePhoneNumberUseCase.launch(user.phoneNumberState.dial);
    return phoneNumber;
  }

  void onDeleteUserPressed() {
    emit(ShowDeleteUser());
  }
}
