import 'package:cleaning_duty_project/core/constants/constants.dart';
import 'package:cleaning_duty_project/core/networks/network_client.dart';
import 'package:cleaning_duty_project/feature/blocs/authenticate/login/bloc/login_bloc.dart';
import 'package:cleaning_duty_project/feature/data/db/secure_storage.dart';
import 'package:cleaning_duty_project/feature/data/remote/authenticate/authenticate.dart';
import 'package:cleaning_duty_project/feature/data/remote/authenticate/authenticate_network_client.dart';
import 'package:cleaning_duty_project/feature/routers/route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MainApp());
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) {
        return RepositoryProvider(
          create: (context) => AuthenticationRepositoryImpl(
              authenticateNetworkClient: AuthenticateNetworkClient(
                  secureStorage: SecureStorage(),
                  networkClient: NetworkClient(dio: Dio()))),
          child: BlocProvider(
            create: (context) =>
                LoginBloc(context.read<AuthenticationRepositoryImpl>()),
            child: MaterialApp.router(
              theme: ThemeData(
                fontFamily: Constants.app_font_DM_Sans,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme:
                    const AppBarTheme(backgroundColor: Colors.blueAccent),
              ),
              routerConfig: router,
            ),
          ),
        );
      },
    );
  }
}
