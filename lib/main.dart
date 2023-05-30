import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/features/group/group_page.dart';
import 'package:billsplit_flutter/presentation/features/groups/groups_page.dart';
import 'package:billsplit_flutter/presentation/features/landing/landing_page.dart';
import 'package:billsplit_flutter/presentation/features/permissions/notifications_rationale.dart';
import 'package:billsplit_flutter/presentation/main_cubit.dart';
import 'package:billsplit_flutter/presentation/main_state.dart';
import 'package:billsplit_flutter/presentation/notifications/fcm_background_handler.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_theme3.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_theme3_dark.dart';
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

class _BillSplitAppState extends State<BillSplitApp>
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
          if (state is GroupOpenedFromNotification) {
            Navigator.of(context).push(GroupPage.getRoute(state.group));
          }
          if (state is ShowNotificationPermissionRationale) {
            Navigator.of(context).push(NotificationsRationale.getRoute());
          }
        },
        child: BaseBlocBuilder<MainCubit>(
          builder: (cubit, state) {
            if (state is Loading) {
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            }
            if (state is Main) {
              return StreamBuilder<String?>(
                stream: cubit.observeAuthState(),
                builder: (context, snapshot) {
                  final uid = snapshot.data;
                  if (uid == null) {
                    _onUserLoggedOut(uid, context);
                    return const LandingPage();
                  }
                  return GroupsPage();
                },
              );
            }
            return const Placeholder();
          },
        ),
      ),
    );
  }

  // delay popUntil to reduce false nulls
  _onUserLoggedOut(String? uid, BuildContext context) {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      if (uid == null) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Eraser.clearAllAppNotifications();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
