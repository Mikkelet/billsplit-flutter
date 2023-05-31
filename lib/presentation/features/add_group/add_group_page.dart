import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/dialogs/currency_picker/currency_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/features/add_group/widgets/add_people_to_group_view.dart';
import 'package:billsplit_flutter/presentation/features/add_group/widgets/added_person_view.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/features/group/group_page.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:flutter/material.dart';

import 'bloc/add_group_cubit.dart';
import 'bloc/add_group_state.dart';

class AddGroupPage extends StatelessWidget {
  AddGroupPage({Key? key}) : super(key: key);

  final nameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget(
      create: (context) => AddGroupCubit(),
      listener: (context, cubit, state) {
        if (state is GroupAdded) {
          Navigator.of(context).pop();
          Navigator.of(context).push(GroupPage.getRoute(state.group));
        }
      },
      child: BaseBlocBuilder<AddGroupCubit>(
        builder: (cubit, state) {
          return Scaffold(
            appBar: AppBar(
              leading: const BackButton(),
              actions: [
                IconButton(
                    onPressed: () {
                      cubit.addGroup();
                    },
                    icon: const Icon(Icons.check))
              ],
            ),
            body: Builder(builder: (context) {
              if (state is Loading) {
                return const Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          cubit.groupName.isEmpty
                              ? "New group"
                              : cubit.groupName,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      const SizedBox(height: 16),
                      RoundedListItem(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(30),
                            bottom: Radius.circular(10),
                          ),
                          child: TextField(
                            autofocus: cubit.groupName.isEmpty,
                            maxLines: 1,
                            maxLength: 40,
                            controller: nameTextController,
                            onChanged: (value) {
                              cubit.onUpdateGroupName(value);
                            },
                            textInputAction: TextInputAction.done,
                            style: SplitsbyTextTheme.textFieldStyle(context),
                            decoration: InputDecoration(
                                hintStyle: SplitsbyTextTheme.textFieldHintStyle(
                                    context),
                                counterText: "",
                                border: InputBorder.none,
                                hintText: "Enter group name"),
                          )),
                      const SizedBox(height: 4),
                      ClickableListItem(
                        padding: const EdgeInsets.all(16),
                        borderRadius: BorderRadius.circular(10),
                        onClick: () async {
                          final response = await Navigator.of(context)
                              .push(CurrencyPickerDialog.getRoute());
                          if (response is Currency) {
                            cubit.updateCurrency(response);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              cubit.currency.toUpperCase(),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Column(
                        children: [
                          RoundedListItem(
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            child: Column(
                              children: [
                                if (cubit.people.isEmpty)
                                  const Text("Add people to the group")
                                else
                                  ...cubit.people
                                      .map((e) => AddedPersonView(person: e))
                                      .toList(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Align(
                            alignment: Alignment.centerRight,
                            child: AddPeopleToGroupView(),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }

  static Route getRoute() => slideUpRoute(AddGroupPage());
}
