import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/firebase_options.dart';
import 'package:billsplit_flutter/presentation/main_cubit.dart';
import 'package:billsplit_flutter/presentation/navigation/app_router.dart';
import 'package:billsplit_flutter/presentation/notifications/fcm_background_handler.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_theme3.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_theme3_dark.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> cameras;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  cameras = await availableCameras();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  final mainCubit = MainCubit(getIt.get());
  await mainCubit.initialize();
  runApp(BillSplitApp());
}


class BillSplitApp extends StatelessWidget {
  const BillSplitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Splitsby',
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale.fromSubtags(languageCode: "en"),
        Locale.fromSubtags(languageCode: "th"),
      ],
      routerConfig: router,
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
    );
  }
}
