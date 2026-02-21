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
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatableTextField extends StatelessWidget {
  final String initState;
  final int charLimit;
  final String hintText;
  final Future Function(String) updateFuture;
  final BorderRadius? borderRadius;

  const UpdatableTextField({
    super.key,
    required this.initState,
    required this.updateFuture,
    this.borderRadius,
    this.hintText = "",
    this.charLimit = 40,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateTextFieldCubit>();
    return BlocProvider(
      create: (context) => UpdateTextFieldCubit(updateFuture, initState),
      child: RoundedListItem(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<UpdateTextFieldCubit, UpdatableTextFieldState>(
          builder: (context, state) {
            if (state.view == UpdatableTextFieldView.display) {
              return Row(
                children: [
                  Expanded(
                    child: Text(
                      initState,
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
                  ),
                ],
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    autofocus: true,
                    style: TextStyle(fontSize: Theme.of(context).textTheme.labelLarge?.fontSize),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hintText,
                      counterText: "",
                    ),
                    maxLines: 1,
                    maxLength: charLimit,
                    controller: cubit.controller,
                    onChanged: (_) {},
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
                    onClick: () {
                        cubit.onUpdatePressed();
                    },
                    color: Colors.green,
                    child: const Icon(Icons.check),
                  ),
                  const SizedBox(width: 4),
                  ClickableListItem(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.zero,
                    onClick: () {
                      cubit.onCancelPressed();
                    },
                    color: Colors.red,
                    child: const Icon(Icons.close),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
