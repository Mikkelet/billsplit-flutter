import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/loading_view.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/features/friends/bloc/add_friend_cubit.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFriendEmailView extends StatefulWidget {
  const AddFriendEmailView({super.key});

  @override
  State<AddFriendEmailView> createState() => _AddFriendEmailViewState();
}

class _AddFriendEmailViewState extends SafeState<AddFriendEmailView> {
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
    return RoundedListItem(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 64,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: SplitsbyTextTheme.textFieldStyle(context),
              controller: _textFieldController,
              decoration: InputDecoration(
                  errorText: errorText,
                  hintStyle: SplitsbyTextTheme.textFieldHintStyle(context),
                  border: InputBorder.none,
                  hintText: "Enter an email"),
              onChanged: (_) {
                setState(() {
                  errorText = null;
                });
              },
            ),
          ),
          LoadingView(
            isLoading: cubit.state is Loading,
            child: IconButton(
              onPressed: () {
                if (!_isEmailValid()) {
                  updateState();
                } else {
                  cubit.addFriendEmail(_textFieldController.text);
                }
              },
              icon: const Icon(Icons.send),
            ),
          )
        ],
      ),
    );
  }

  bool _isEmailValid() {
    if (_textFieldController.text.isEmpty) {
      errorText = "Enter an email";
      return false;
    } else if (!EmailValidator.validate(_textFieldController.text)) {
      errorText = "invalid email";
      return false;
    } else {
      errorText = null;
      return true;
    }
  }
}
