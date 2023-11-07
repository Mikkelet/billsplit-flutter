import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/models/notification_action.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/features/friends/friends_page.dart';
import 'package:billsplit_flutter/presentation/features/group/group_page.dart';
import 'package:billsplit_flutter/presentation/features/group_invites/group_invites_page.dart';
import 'package:billsplit_flutter/presentation/features/groups/groups_page.dart';
import 'package:billsplit_flutter/presentation/features/landing/landing_page.dart';
import 'package:billsplit_flutter/presentation/features/mandatory_update/mandatory_update_page.dart';
import 'package:billsplit_flutter/presentation/features/permissions/notifications_rationale.dart';
import 'package:billsplit_flutter/presentation/features/splash/splash_page.dart';
import 'package:billsplit_flutter/presentation/main_cubit.dart';
import 'package:billsplit_flutter/presentation/main_state.dart';
import 'package:billsplit_flutter/presentation/notifications/fcm_background_handler.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_theme3.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_theme3_dark.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:camera/camera.dart';
import 'package:eraser/eraser.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'presentation/common/base_bloc_widget.dart';

late List<CameraDescription> cameras;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  cameras = await availableCameras();
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(const BillSplitApp());
}

enum NavRoute {
  groups,
  group,
  loading,
}

class BillSplitApp extends StatefulWidget {
  const BillSplitApp({super.key});

  @override
  State<BillSplitApp> createState() => _BillSplitAppState();
}

class _BillSplitAppState extends SafeState<BillSplitApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splitsby',
      supportedLocales: const [
        Locale.fromSubtags(languageCode: "en"),
        Locale.fromSubtags(languageCode: "th"),
      ],
      darkTheme: ThemeData(
        fontFamily: "Montserrat",
        colorScheme: const SplitsbyTheme3Dark(),
        textTheme: const SplitsbyTextTheme(),
        useMaterial3: true,
      ),
      theme: ThemeData(
        splashFactory: InkSplash.splashFactory,
        fontFamily: "Montserrat",
        textTheme: const SplitsbyTextTheme(),
        colorScheme: const SplitsbyTheme3(),
        useMaterial3: true,
      ),
      home: BaseBlocWidget(
        create: (context) => MainCubit()..initialize(),
        listener: (context, cubit, state) async {
          if (state is NotificationActionEvent) {
            final action = state.notificationAction;
            if (action is OpenGroupAction) {
              Navigator.of(context).push(GroupPage.getRoute(action.group));
            } else if (action is OpenFriendInvitesAction) {
              Navigator.of(context).push(FriendsPage.route);
            } else if (action is OpenGroupInvitesAction) {
              Navigator.of(context).push(GroupInvitesPage.route);
            }
          } else if (state is ShowNotificationPermissionRationale) {
            Navigator.of(context).push(NotificationsRationale.getRoute());
          } else if (state is MandatoryUpdateState) {
            Navigator.of(context)
                .push(MandatoryUpdatePage.getRoute(state.appVersion));
          }
        },
        child: BaseBlocBuilder<MainCubit>(
          builder: (cubit, state) {
            if (state is Main) {
              cubit.checkAppVersion();
              return StreamBuilder<AuthState>(
                stream: cubit.observeAuthState(),
                initialData: LoadingUserState(),
                builder: (context, snapshot) {
                  final authState = snapshot.data;
                  if (authState is LoggedOutState) {
                    _onUserLoggedOut(context);
                    return const LandingPage();
                  } else if (authState is LoggedInState) {
                    return GroupsPage();
                  } else {
                    return const SplashPage();
                  }
                },
              );
            } else {
              return const SplashPage();
            }
          },
        ),
      ),
    );
  }

  // delay popUntil to reduce false nulls
  _onUserLoggedOut(BuildContext context) {
    Navigator.of(context).popUntil((route) =>
        route.settings.name == "/${MandatoryUpdatePage.routeName}" ||
        route.isFirst);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      Eraser.clearAllAppNotifications();
      updateState();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
