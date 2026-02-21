import 'package:billsplit_flutter/domain/models/friend.dart';
import 'package:billsplit_flutter/domain/use_cases/friends/add_friend_email_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/friends/add_friend_phone_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/friends/add_friend_uid_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/friends/get_friends_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/friends/observe_friends_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/profile/parse_phonenumber_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/safe_cubit.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:billsplit_flutter/presentation/features/friends/bloc/friend_state.dart';
import 'package:country_code_picker/country_code_picker.dart';

enum AddFriendType { none, email, phone }

class FriendsCubit extends SafeCubit<FriendsState> {
  final _getFriendsUseCase = GetFriendsUseCase();
  final _observeFriendsUseCase = ObserveFriendsUseCase();
  final _addFriendUserIdUseCase = AddFriendUserIdUseCase();
  final _addFriendEmailUseCase = AddFriendEmailUseCase();
  final _addFriendPhoneUseCase = AddFriendPhoneUseCase();
  final _parsePhoneNumberUseCase = ParsePhoneNumberUseCase();

  FriendsCubit() : super(const FriendsState());

  Stream<Iterable<Friend>> friendsStream() => _observeFriendsUseCase.observe();

  Future<void> init() async {
    try {
      safeEmit(state.copyWith(isLoading: true));
      await _getFriendsUseCase.launch();
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  Future refreshFriends() async {
    try {
      await _getFriendsUseCase.launch();
    } catch (e, st) {
      logError(e, st);
    }
  }

  void _parsePhoneNumber() async {
    final parsed = await _parsePhoneNumberUseCase.launch("user.phoneNumberState.value.dial");
    if (parsed != null) {
      safeEmit(state.copyWith(dialCode: parsed.countryCode));
    }
  }

  void addFriendUserId(String userId) async {
    try {
      safeEmit(state.copyWith(isLoading: true));
      await _addFriendUserIdUseCase.launch(userId);
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  void addFriendEmail(String email) async {
    try {
      safeEmit(state.copyWith(isLoading: true));
      await _addFriendEmailUseCase.launch(email);
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  void onAddFriendTypeClicked(AddFriendType addFriendType) {
    if (state.selectedAddFriendType == addFriendType) {
      safeEmit(state.copyWith(selectedAddFriendType: AddFriendType.none));
    } else {
      safeEmit(state.copyWith(selectedAddFriendType: addFriendType));
    }
  }

  void changeCountryCode(CountryCode countryCode) {
    if (countryCode.dialCode != null) {
      safeEmit(state.copyWith(dialCode: countryCode.dialCode!));
    }
  }

  void addFriendPhone(String phoneNumber) async {
    try {
      safeEmit(state.copyWith(isLoading: true));
      final phoneNumberWithCountryCode = "${state.dialCode}$phoneNumber";
      await _addFriendPhoneUseCase.launch(phoneNumberWithCountryCode);
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }
}
