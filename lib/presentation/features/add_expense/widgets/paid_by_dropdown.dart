import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/individual_expense_view.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaidByDropDownView extends StatefulWidget {
  final Iterable<Person> people;
  final bool showExpenses;

  const PaidByDropDownView(
      {Key? key, required this.people, this.showExpenses = true})
      : super(key: key);

  @override
  State<PaidByDropDownView> createState() => _PaidByDropDownViewState();
}

class _PaidByDropDownViewState extends SafeState<PaidByDropDownView> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    return ExpansionPanelList(
      expandedHeaderPadding: const EdgeInsets.only(bottom: 4),
      elevation: 0,
      children: [
        // To remove the downward arrow, see:
        // https://stackoverflow.com/questions/63437671/flutter-how-to-remove-icon-from-expansion-panel
        ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return ClickableListItem(
                padding: EdgeInsets.zero,
                onClick: () {
                  setState(() {
                    this.isExpanded = !this.isExpanded;
                  });
                },
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Paid by",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProfilePictureView(
                              size: 40, person: cubit.groupExpense.payerState),
                        ),
                      ],
                    ),
                    if (!isExpanded)
                      Container(
                        height: 10,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .secondaryContainer,
                        ),
                        child: Center(child: Container(height: 1, width: 64, color: Theme.of(context).colorScheme.onSecondaryContainer,)),
                      )
                  ],
                ),
              );
            },
            backgroundColor: Colors.transparent,
            isExpanded: isExpanded,
            body: RoundedListItem(
              child: Column(
                children: [
                  ...widget.people.mapIndexed(
                    (i, e) => Padding(
                      padding: EdgeInsets.only(top: i > 0 ? 8.0 : 0),
                      child: IndividualExpenseView(e, showExpense: true),
                    ),
                  )
                ],
              ),
            ),
            canTapOnHeader: true)
      ],
    );
  }
}
