import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_scaffold.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/features/currency_picker/currency_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/features/add_group/widgets/add_people_to_group_view.dart';
import 'package:billsplit_flutter/presentation/features/add_group/widgets/added_person_view.dart';
import 'package:billsplit_flutter/presentation/features/currency_picker/currency_picker_route.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/presentation/utils/bloc_utils.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'bloc/add_group_cubit.dart';
import 'bloc/add_group_state.dart';

class AddGroupPage extends StatelessWidget {
  const AddGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddGroupCubit>();
    return BlocListener<AddGroupCubit, AddGroupState>(
      listenWhen: (prev, curr) => curr.isAdded,
      listener: (context, state) {
        context.pop();
        // GroupRoute(cubit.group.id).push(context);
      },
      child: BlocBuilder<AddGroupCubit, AddGroupState>(
        builder: (context, state) {
          return BaseScaffold(
            appBar: AppBar(
              forceMaterialTransparency: true,
              leading: const BackButton(),
              actions: [
                IconButton(
                  onPressed: () {
                    cubit.addGroup();
                  },
                  icon: const Icon(Icons.check),
                ),
              ],
            ),
            body: Builder(
              builder: (context) {
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
                            state.groupName.isEmpty ? "New group" : state.groupName,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                        const SizedBox(height: 16),
                        RoundedListItem(
                          child: TextField(
                            autofocus: state.groupName.isEmpty,
                            maxLines: 1,
                            maxLength: 40,
                            controller: cubit.nameTextController,
                            onChanged: (value) {},
                            textInputAction: TextInputAction.done,
                            style: SplitsbyTextTheme.textFieldStyle(context),
                            decoration: InputDecoration(
                              hintStyle: SplitsbyTextTheme.textFieldHintStyle(context),
                              counterText: "",
                              border: InputBorder.none,
                              hintText: "Enter group name",
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ClickableListItem(
                          padding: const EdgeInsets.all(16),
                          onClick: () async {
                            final response = await CurrencyPickerRoute().push(context);
                            if (response is Currency) {
                              cubit.updateCurrency(response);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.currency.toUpperCase(),
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        Column(
                          children: [
                            RoundedListItem(
                              child: Column(
                                children: [
                                  AddedPersonView(person: context.user),
                                  if (state.people.isEmpty)
                                    const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text("Invite people to the group"),
                                    )
                                  else
                                    ...state.people.map(
                                      (e) => AddedPersonView(person: e),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Align(
                              alignment: Alignment.centerRight,
                              child: AddPeopleToGroupView(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  static Route getRoute() => slideUpRoute(AddGroupPage());
}
