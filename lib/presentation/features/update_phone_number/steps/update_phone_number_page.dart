import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/loading_view.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/features/update_phone_number/bloc/update_phone_number_cubit.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePhoneNumberPage extends StatefulWidget {
  final String phoneNumber;

  const UpdatePhoneNumberPage({super.key, required this.phoneNumber});

  @override
  State<UpdatePhoneNumberPage> createState() => _UpdatePhoneNumberPageState();
}

class _UpdatePhoneNumberPageState extends SafeState<UpdatePhoneNumberPage> {
  late final TextEditingController _textEditingController =
      TextEditingController()..text = widget.phoneNumber;

  @override
  void initState() {
    _textEditingController.addListener(_textListener);
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_textListener);
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdatePhoneNumberCubit>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            "Update phone number",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          RoundedListItem(
            child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              controller: _textEditingController,
            ),
          ),
          const SizedBox(height: 8),
          LoadingView(
            state: cubit.state,
            child: ClickableListItem(
              enabled: _textEditingController.text != cubit.phoneNumber,
              width: 64,
              height: 64,
              onClick: () {
                final phoneNumber = _textEditingController.text;
                cubit.sendSms(phoneNumber);
              },
              child: const Icon(Icons.send),
            ),
          ),
        ],
      ),
    );
  }

  void _textListener() {
    updateState();
  }
}
