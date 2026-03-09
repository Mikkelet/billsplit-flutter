import 'package:billsplit_flutter/presentation/features/add_expense/add_expense_route.dart';
import 'package:billsplit_flutter/presentation/features/add_group/add_group_route.dart';
import 'package:billsplit_flutter/presentation/features/add_service/add_service_route.dart';
import 'package:billsplit_flutter/presentation/features/currency_picker/currency_picker_route.dart';
import 'package:billsplit_flutter/presentation/features/developer_settings/developer_settings_route.dart';
import 'package:billsplit_flutter/presentation/features/friends/friends_route.dart';
import 'package:billsplit_flutter/presentation/features/group/group_route.dart';
import 'package:billsplit_flutter/presentation/features/group_invites/group_invites_route.dart';
import 'package:billsplit_flutter/presentation/features/group_settings/group_settings_route.dart';
import 'package:billsplit_flutter/presentation/features/groups/groups_route.dart';
import 'package:billsplit_flutter/presentation/features/inspect_profile/inspect_profile_route.dart';
import 'package:billsplit_flutter/presentation/features/landing/landing_route.dart';
import 'package:billsplit_flutter/presentation/features/notifications_settings/notifications_settings_route.dart';
import 'package:billsplit_flutter/presentation/features/onboarding/onboarding_route.dart';
import 'package:billsplit_flutter/presentation/features/permissions/notification_rationale_route.dart';
import 'package:billsplit_flutter/presentation/features/profile/profile_route.dart';
import 'package:billsplit_flutter/presentation/features/scan_receipt/scan_receipt_route.dart';
import 'package:billsplit_flutter/presentation/features/splash/splash_route.dart';
import 'package:billsplit_flutter/presentation/features/update_phone_number/update_phone_number_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

abstract class AppRoutes {
  static const splash = "/";
  static const home = "/home";
  static const group = "/groups/:id";
  static const groupSettings = "/groups/:id/settings";
  static const expense = "/expense/:id";
  static const profile = "/profile";
  static const friends = "/friends";
  static const groupsInvites = "group-invites";
  static const inspectProfile = "/users/:id";
  static const scanReceipt = "/scan";
  static const addGroup = "/add-group";
  static const addService = "/add-service";
  static const addExpense = "/add-expense";
  static const onboarding = "/onboarding";
  static const landing = "/landing";
}

final rootNavKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavKey,
  initialLocation: AppRoutes.splash,
  redirect: (context, state) {
    return null;
  },
  routes: [
    $landingRoute,
    $updatePhoneNumberRoute,
    $groupInvitesRoute,
    $friendsRoute,
    $groupRoute,
    $addServiceRoute,
    $scanReceiptRoute,
    $notificationsSettingsRoute,
    $splashRoute,
    $profileRoute,
    $addExpenseRoute,
    $addGroupRoute,
    $currencyPickerRoute,
    $groupSettingsRoute,
    $inspectProfileRoute,
    $notificationRationaleRoute,
    $onboardingRoute,
    $developerSettingsRoute,
    $groupsRoute,
  ],
);
