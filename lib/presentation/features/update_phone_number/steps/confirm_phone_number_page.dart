import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/loading_view.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/features/update_phone_number/bloc/update_phone_number_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmPhoneNumberPage extends StatefulWidget {

  // cannot be const due to update state
  const ConfirmPhoneNumberPage({super.key});

  @override
  State<ConfirmPhoneNumberPage> createState() => _ConfirmPhoneNumberPageState();
}

class _ConfirmPhoneNumberPageState extends State<ConfirmPhoneNumberPage> {
  late final TextEditingController _textEditingController =
      TextEditingController();

  @override
  void dispose() {
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
            "Enter SMS code",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          RoundedListItem(
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 8),
          LoadingView(
            isLoading: cubit.state is Loading,
            child: ClickableListItem(
              width: 64,
              height: 64,
              onClick: () {
                final smsCode = _textEditingController.text;
                cubit.submitCode(smsCode);
              },
              child: const Icon(Icons.send),
            ),
          ),
        ],
      ),
    );
  }
}
