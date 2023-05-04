import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/profile/bloc/profile_cubit.dart';
import 'package:billsplit_flutter/presentation/profile/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayNameTextField extends StatefulWidget {
  const DisplayNameTextField({Key? key}) : super(key: key);

  @override
  State<DisplayNameTextField> createState() => _DisplayNameTextFieldState();
}

class _DisplayNameTextFieldState extends State<DisplayNameTextField> {
  bool isEditing = false;
  final _nameTextController = TextEditingController();

  @override
  void dispose() {
    _nameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocBuilder<ProfileCubit>(
      builder: (cubit, state) {
        return BlocListener<ProfileCubit, UiState>(
          listener: (context, state) {
            if (state is DisplayNameUpdated || state is Failure) {
              setState(() {
                isEditing = false;
              });
            }
          },
          child: Builder(
            builder: (context) {
              if (!isEditing) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cubit.user.nameState,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isEditing = true;
                        });
                      },
                      icon: const Icon(Icons.edit),
                      color: Theme.of(context).colorScheme.secondary,
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
                        counterText: ""
                      ),
                      maxLines: 1,
                      maxLength: 20,
                      controller: _nameTextController
                        ..text = cubit.user.nameState,
                      onChanged: (val) {
                        cubit.user.nameState = val;
                      },
                    ),
                  ),
                  if (cubit.state is UpdateDisplayNameLoading)
                    const CircularProgressIndicator()
                  else ...[
                    IconButton(
                      onPressed: () {
                        cubit.changeName();
                        setState(() {});
                      },
                      icon: const Icon(Icons.check),
                      color: Colors.green,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          cubit.user.resetChanges();
                          isEditing = false;
                        });
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
      },
    );
  }
}
