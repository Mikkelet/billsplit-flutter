import 'package:billsplit_flutter/presentation/dialogs/custom_dialog.dart';
import 'package:flutter/material.dart';

class ResetChangesDialog extends Dialog {
  final Function() resetChanges;

  const ResetChangesDialog(this.resetChanges, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      text: "You have made changes. Do you want keep editing or cancel?",
      primaryText: "Keep editing",
      onPrimaryClick: () {
        Navigator.of(context).pop(false);
      },
      secondaryText: "Cancel changes",
      onSecondaryClick: () {
        resetChanges();
        Navigator.of(context).pop(true);
      },
    );
  }
}
