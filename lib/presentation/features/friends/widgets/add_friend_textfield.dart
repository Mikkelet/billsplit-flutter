import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/features/friends/bloc/add_friend_cubit.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class AddFriendTextField extends StatefulWidget {
  const AddFriendTextField({Key? key}) : super(key: key);

  @override
  State<AddFriendTextField> createState() => _AddFriendTextFieldState();
}

class _AddFriendTextFieldState extends SafeState<AddFriendTextField> {
  final textFieldController = TextEditingController();
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget(
      create: (context) => AddFriendCubit(),
      child: BaseBlocBuilder<AddFriendCubit>(
        builder: (cubit, state) {
          return RoundedListItem(
            padding: 16,
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    style: SplitsbyTextTheme.textFieldStyle(context),
                    controller: textFieldController,
                    decoration: InputDecoration(
                        errorText: errorText,
                        hintStyle:
                            SplitsbyTextTheme.textFieldHintStyle(context),
                        border: InputBorder.none,
                        hintText: "Enter an email"),
                    onChanged: (_) {
                      setState(() {
                        errorText = null;
                      });
                    },
                  ),
                ),
                builder(() {
                  if (state is Loading) {
                    return const CircularProgressIndicator();
                  }
                  return IconButton(
                      onPressed: () {
                        if (!_isEmailValid()) {
                          updateState();
                        } else {
                          cubit.addFriendEmail(textFieldController.text);
                        }
                      },
                      icon: const Icon(Icons.send));
                })
              ],
            ),
          );
        },
      ),
    );
  }

  bool _isEmailValid() {
    if (textFieldController.text.isEmpty) {
      errorText = "Enter an email";
      return false;
    } else if (!EmailValidator.validate(textFieldController.text)) {
      errorText = "invalid email";
      return false;
    } else {
      errorText = null;
      return true;
    }
  }
}
