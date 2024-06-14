import 'package:billsplit_flutter/domain/use_cases/friends/add_friend_email_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/friends/add_friend_phone_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/friends/add_friend_uid_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/profile/parse_phonenumber_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/utils/errors_utils.dart';
import 'package:country_code_picker/country_code_picker.dart';

enum AddFriendType {
  none,
  email,
  phone;
}

class AddFriendCubit extends BaseCubit {
  final _addFriendUserIdUseCase = AddFriendUserIdUseCase();
  final _addFriendEmailUseCase = AddFriendEmailUseCase();
  final _addFriendPhoneUseCase = AddFriendPhoneUseCase();
  final _parsePhoneNumberUseCase = ParsePhoneNumberUseCase();

  AddFriendType selectedAddFriendType = AddFriendType.none;
  String countryCode = "+45";

  void init() {
    _parsePhoneNumberUseCase.launch(user.phoneNumberState.value.dial).then((parsed) {
      if (parsed == null) return;
      countryCode = parsed.countryCode;
    });
  }

  void addFriendUserId(String userId) {
    emit(Loading());
    _addFriendUserIdUseCase.launch(userId).then((value) {
      emit(Main());
    }).catchError((err, st) {
      showError(err, st);
    });
  }

  void addFriendEmail(String email) {
    emit(Loading());
    _addFriendEmailUseCase.launch(email).then((value) {
      emit(Main());
    }).catchError((err, st) {
      showError(err, st);
    });
  }

  void onAddFriendTypeClicked(AddFriendType addFriendType) {
    if (selectedAddFriendType == addFriendType) {
      selectedAddFriendType = AddFriendType.none;
    } else {
      selectedAddFriendType = addFriendType;
    }
    emit(Main());
  }

  void changeCountryCode(CountryCode countryCode) {
    if (countryCode.dialCode == null) {
      emit(Failure(UiException(400, "unexpected error occurred")));
    } else {
      this.countryCode = countryCode.dialCode!;
      emit(Main());
    }
  }

  void addFriendPhone(String phoneNumber) {
    emit(Loading());
    final phoneNumberWithCountryCode = "$countryCode$phoneNumber";
    _addFriendPhoneUseCase.launch(phoneNumberWithCountryCode).then((_) {
      emit(Main());
    }).catchError((err, stackTrace) {
      showError(err, stackTrace);
    });
  }
}
