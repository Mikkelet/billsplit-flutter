import 'package:billsplit_flutter/presentation/common/billsplit_country_picker.dart';
import 'package:billsplit_flutter/presentation/common/loading_view.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/features/friends/bloc/add_friend_cubit.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFriendPhoneView extends StatefulWidget {

  // removed const to trigger state changes
  AddFriendPhoneView({super.key});

  @override
  State<AddFriendPhoneView> createState() => _AddFriendPhoneViewState();
}

class _AddFriendPhoneViewState extends SafeState<AddFriendPhoneView> {
  final _textFieldController = TextEditingController();
  String? errorText;

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddFriendCubit>();
    return Row(
      children: [
        BillSplitCountryPicker(
          initialCountry: cubit.countryCode,
          onChange: (countryCode) {
            cubit.changeCountryCode(countryCode);
          },
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RoundedListItem(
            height: 64,
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: SplitsbyTextTheme.textFieldStyle(context),
                    controller: _textFieldController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        errorText: errorText,
                        hintStyle:
                            SplitsbyTextTheme.textFieldHintStyle(context),
                        border: InputBorder.none,
                        hintText: "Enter a phone number"),
                    onChanged: (_) {
                      setState(() {
                        errorText = null;
                      });
                    },
                  ),
                ),
                LoadingView(
                  state: cubit.state,
                  child: IconButton(
                    onPressed: () {
                      if (!_isPhoneValid()) {
                        updateState();
                      } else {
                        cubit.addFriendPhone(_textFieldController.text);
                      }
                    },
                    icon: const Icon(Icons.send),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  bool _isPhoneValid() {
    if (_textFieldController.text.isEmpty) {
      errorText = "Enter a phone number";
      return false;
    } else {
      errorText = null;
      return true;
    }
  }
}
