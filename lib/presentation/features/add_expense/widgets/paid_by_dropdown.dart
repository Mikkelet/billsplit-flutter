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
  final Iterable<Person> participants;
  final bool showExpenses;

  const PaidByDropDownView(
      {Key? key, required this.participants, this.showExpenses = true})
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
              return Column(
                children: [
                  ClickableListItem(
                    height: 54,
                    padding: EdgeInsets.zero,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10),
                      bottom: Radius.zero,
                    ),
                    onClick: () {
                      setState(() {
                        this.isExpanded = !this.isExpanded;
                      });
                    },
                    child: Row(
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
                        )
                      ],
                    ),
                  ),
                  RoundedListItem(
                    height: 10,
                    color: _getBottomBarColor(isExpanded),
                    borderRadius: _getBottomBarRadius(isExpanded),
                    child: const SizedBox(),
                  )
                ],
              );
            },
            backgroundColor: Colors.transparent,
            isExpanded: isExpanded,
            body: Column(
              children: [
                ...widget.participants.mapIndexed(
                  (i, e) => Padding(
                    padding: EdgeInsets.only(top: i > 0 ? 4.0 : 0),
                    child: IndividualExpenseView(e, showExpense: true),
                  ),
                )
              ],
            ),
            canTapOnHeader: true)
      ],
    );
  }

  Color _getBottomBarColor(bool isExpanded) {
    if (isExpanded) {
      return Theme.of(context).colorScheme.primaryContainer;
    }
    return Theme.of(context).colorScheme.secondaryContainer;
  }

  BorderRadius _getBottomBarRadius(bool isExpanded) {
    if (isExpanded) {
      return const BorderRadius.vertical(
        top: Radius.zero,
        bottom: Radius.circular(30),
      );
    }
    return const BorderRadius.vertical(
      top: Radius.zero,
      bottom: Radius.circular(10),
    );
  }
}
