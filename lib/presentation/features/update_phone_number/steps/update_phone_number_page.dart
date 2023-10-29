import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/loading_view.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/features/update_phone_number/bloc/update_phone_number_cubit.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePhoneNumberPage extends StatefulWidget {
  final String phoneNumber;
  final String initialCountry;

  const UpdatePhoneNumberPage(
      {super.key, required this.phoneNumber, required this.initialCountry});

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
          Row(
            children: [
              RoundedListItem(
                height: 64,
                padding: EdgeInsets.zero,
                child: CountryCodePicker(
                  padding: EdgeInsets.zero,
                  initialSelection: widget.initialCountry,
                  countryFilter: const ["DK", "TH"],
                  onChanged: (country) {
                    cubit.changeCountryCode(country);
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: RoundedListItem(
                  height: 64,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    style: Theme.of(context).textTheme.labelLarge,
                    keyboardType: const TextInputType.numberWithOptions(),
                    controller: _textEditingController,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LoadingView(
            state: cubit.state,
            child: ClickableListItem(
              enabled: cubit.isPhoneNumberChanged(_textEditingController.text),
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
