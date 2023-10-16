import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/common/update_textfield/update_textfield_cubit.dart';
import 'package:billsplit_flutter/presentation/common/update_textfield/update_textfield_state.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum UpdateTextFieldState { isUpdating, isEditing, display }

class UpdatableTextField extends StatefulWidget {
  final String initState;
  final int charLimit;
  final String hintText;
  final Future Function(String) updateFuture;
  final BorderRadius? borderRadius;

  const UpdatableTextField(
      {Key? key,
      required this.initState,
      required this.updateFuture,
      this.borderRadius,
      this.hintText = "",
      this.charLimit = 40})
      : super(key: key);

  @override
  State<UpdatableTextField> createState() => _UpdatableTextField();
}

class _UpdatableTextField extends SafeState<UpdatableTextField> {
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
      child: RoundedListItem(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BaseBlocBuilder<UpdateTextFieldCubit>(
          builder: (cubit, state) {
            if (state is DisplayText) {
              return Row(
                children: [
                  Expanded(
                    child: Text(
                      currentState,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  const SizedBox(width: 4),
                  ClickableListItem(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.zero,
                    onClick: () {
                      HapticFeedback.heavyImpact();
                      cubit.onEditPressed();
                    },
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: const Icon(Icons.edit),
                  )
                ],
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    autofocus: true,
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.labelLarge?.fontSize),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.hintText,
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
                const SizedBox(width: 4),
                if (state is Loading)
                  const CircularProgressIndicator()
                else ...[
                  ClickableListItem(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.zero,
                    borderRadius: BorderRadius.circular(10),
                    onClick: () {
                      if (currentState != widget.initState) {
                        cubit.onUpdatePressed(currentState);
                      } else {
                        cubit.onCancelPressed();
                      }
                    },
                    color: Colors.green,
                    child: const Icon(Icons.check),
                  ),
                  const SizedBox(width: 4),
                  ClickableListItem(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.zero,
                    borderRadius: BorderRadius.only(
                      topRight: widget.borderRadius?.topRight ??
                          const Radius.circular(10),
                      topLeft: const Radius.circular(10),
                      bottomLeft: const Radius.circular(10),
                      bottomRight: widget.borderRadius?.bottomRight ??
                          const Radius.circular(10),
                    ),
                    onClick: () {
                      currentState = widget.initState;
                      controller.text = widget.initState;
                      cubit.onCancelPressed();
                    },
                    color: Colors.red,
                    child: const Icon(Icons.close),
                  ),
                ]
              ],
            );
          },
        ),
      ),
    );
  }
}
