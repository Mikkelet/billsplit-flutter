import 'package:billsplit_flutter/presentation/utils/errors_utils.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends Dialog {
  final UiException error;

  const ErrorDialog(this.error, {super.key});

  @override
  Widget build(BuildContext context) {
    print(error);
    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Error occurred!",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(error.toString()),
              const SizedBox(height: 16),
              MaterialButton(
                color: Theme.of(context).primaryColorLight,
                elevation: 0,
                highlightElevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
