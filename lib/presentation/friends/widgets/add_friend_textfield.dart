import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/friends/bloc/add_friend_cubit.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFriendTextField extends StatefulWidget {
  const AddFriendTextField({Key? key}) : super(key: key);

  @override
  State<AddFriendTextField> createState() => _AddFriendTextFieldState();
}

class _AddFriendTextFieldState extends State<AddFriendTextField> {
  final textFieldController = TextEditingController();
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget(
      create: (context) => AddFriendCubit(),
      child: BlocBuilder<AddFriendCubit, UiState>(
        builder: (context, state) {
          return RoundedListItem(
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: textFieldController,
                    decoration: InputDecoration(
                        errorText: errorText,
                        border: InputBorder.none,
                        hintText: "Enter an email"),
                    onChanged: (_) {
                      if (errorText != null) {
                        errorText = null;
                        setState(() {});
                      }
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
                          setState(() {});
                          return;
                        }
                        context
                            .read<AddFriendCubit>()
                            .addFriendEmail(textFieldController.text);
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
    } else if (EmailValidator.validate(textFieldController.text)) {
      errorText = null;
      return false;
    } else {
      errorText = "invalid email";
      return true;
    }
  }
}
