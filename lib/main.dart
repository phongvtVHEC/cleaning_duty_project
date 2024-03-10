import 'package:cleaning_duty_project/core/constants/constants.dart';
import 'package:cleaning_duty_project/feature/di/dependency_injection.dart';
import 'package:cleaning_duty_project/feature/routers/route.dart';
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
  // Show the splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Run the app
  runApp(const MainApp());
  // Remove the splash screen after 1 second
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();
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
