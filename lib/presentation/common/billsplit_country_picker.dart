import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class BillSplitCountryPicker extends StatelessWidget {
  final String initialCountry;
  final Function(CountryCode) onChange;

  const BillSplitCountryPicker(
      {super.key, required this.initialCountry, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return RoundedListItem(
      height: 64,
      padding: EdgeInsets.zero,
      child: CountryCodePicker(
        padding: EdgeInsets.zero,
        initialSelection: initialCountry,
        countryFilter: const ["DK", "TH"],
        searchDecoration: const InputDecoration(
          border: InputBorder.none,
        ),
        dialogBackgroundColor: Theme.of(context).colorScheme.background,
        onChanged: onChange,
        boxDecoration: const BoxDecoration(),
      ),
    );
  }
}
