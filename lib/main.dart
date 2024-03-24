import 'dart:io';
import 'package:cleaning_duty_project/core/constants/constants.dart';
import 'package:cleaning_duty_project/feature/data/remote/devices/device_network_client.dart';
import 'package:cleaning_duty_project/feature/data/repository/devices/devices.dart';
import 'package:cleaning_duty_project/feature/di/dependency_injection.dart';
import 'package:cleaning_duty_project/feature/routers/route.dart';
import 'package:cleaning_duty_project/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  //Register all the dependencies
  setupLocator();
  //Load the .env file
  await dotenv.load(fileName: ".env");
  // Make sure that the FlutterBinding is initialized
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initFirebase();
  // Show the splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Run the app
  runApp(const MainApp());
  // Remove the splash screen after 1 second
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();
}

Future<void> initFirebase() async {
  if (Platform.isIOS) {
    // Handle iOS specific initialization, including obtaining APNS token
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance.getAPNSToken();
  } else {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
  initNotification();
}

Future<void> initNotification() async {
  DevicesRepositoryImpl devicesRepositoryImpl = DevicesRepositoryImpl(
    devicesNetworkClient: locator<DevicesNetworkClient>(),
  );
  await FirebaseMessaging.instance.requestPermission();
  final fCMToken = await FirebaseMessaging.instance.getToken();
  var response = await devicesRepositoryImpl.createDevice(fCMToken ?? '');
  if (response == 200) {
    if (kDebugMode) {
      print('Saving Device Token Success: $fCMToken');
    }
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: Constants.app_font_DM_Sans,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(backgroundColor: Colors.blueAccent),
          ),
          routeInformationProvider: AppRouter.router.routeInformationProvider,
          routeInformationParser: AppRouter.router.routeInformationParser,
          routerDelegate: AppRouter.router.routerDelegate,
        );
      },
    );
  }
}
