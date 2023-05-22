import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/update_textfield/update_textfield_cubit.dart';
import 'package:billsplit_flutter/presentation/common/update_textfield/update_textfield_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum UpdateTextFieldState { isUpdating, isEditing, display }

class UpdatableTextField extends StatefulWidget {
  final String initState;
  final int charLimit;
  final Future Function(String) updateFuture;

  const UpdatableTextField(
      {Key? key,
      required this.initState,
      required this.updateFuture,
      this.charLimit = 40})
      : super(key: key);

  @override
  State<UpdatableTextField> createState() => _UpdatableTextField();
}

class _UpdatableTextField extends State<UpdatableTextField> {
  late String currentState = widget.initState;
  late final controller = TextEditingController(text: currentState);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget<UpdateTextFieldCubit>(
      create: (context) => UpdateTextFieldCubit(widget.updateFuture),
      child: BaseBlocBuilder<UpdateTextFieldCubit>(
        builder: (cubit, state) {
          if (state is DisplayText) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    currentState,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                CircleAvatar(
                  backgroundColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                  child: IconButton(
                    onPressed: () {
                      HapticFeedback.heavyImpact();
                      cubit.onEditPressed();
                    },
                    icon: const Icon(Icons.edit),
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                )
              ],
            );
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: "",
                  ),
                  maxLines: 1,
                  maxLength: widget.charLimit,
                  controller: controller,
                  onChanged: (val) {
                    currentState = val;
                  },
                ),
              ),
              if (state is Loading)
                const CircularProgressIndicator()
              else ...[
                IconButton(
                  onPressed: () {
                    if (currentState != widget.initState) {
                      cubit.onUpdatePressed(currentState);
                    } else {
                      cubit.onCancelPressed();
                    }
                  },
                  icon: const Icon(Icons.check),
                  color: Colors.green,
                ),
                IconButton(
                  onPressed: () {
                    currentState = widget.initState;
                    controller.text = widget.initState;
                    cubit.onCancelPressed();
                  },
                  icon: const Icon(Icons.close),
                  color: Colors.red,
                ),
              ]
            ],
          );
        },
      ),
    );
  }
}
