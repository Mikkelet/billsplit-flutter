import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? error;
  final BorderRadius borderRadius;
  final String hintText;

  const PasswordTextField(
      {Key? key,
      this.borderRadius = BorderRadius.zero,
      required this.controller,
      required this.error,
      required this.hintText})
      : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends SafeState<PasswordTextField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RoundedListItem(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            borderRadius: BorderRadius.only(
              topRight: Radius.zero,
              bottomRight: Radius.zero,
              topLeft: widget.borderRadius.topLeft,
              bottomLeft: widget.borderRadius.bottomLeft,
            ),
            child: TextField(
              controller: widget.controller,
              style: SplitsbyTextTheme.textFieldStyle(context),
              decoration: InputDecoration(
                hintStyle: SplitsbyTextTheme.textFieldHintStyle(context),
                errorText: widget.error,
                border: InputBorder.none,
                errorStyle: SplitsbyTextTheme.textFieldErrorText(context),
                hintText: widget.hintText,
              ),
              obscureText: !showPassword,
              enableSuggestions: false,
              autocorrect: false,
            ),
          ),
        ),
        ClickableListItem(
            width: 64,
            height: 64,
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.zero,
              topLeft: Radius.zero,
              bottomRight: widget.borderRadius.bottomRight,
              topRight: widget.borderRadius.topRight,
            ),
            color: builder(() {
              if (showPassword) {
                return Theme.of(context).colorScheme.secondaryContainer;
              }
              return Theme.of(context).colorScheme.primaryContainer;
            }),
            onClick: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            child: Icon(builder(() {
              if (showPassword) {
                return Icons.visibility;
              } else {
                return Icons.visibility_off;
              }
            })))
      ],
    );
  }
}
