import 'package:cleaning_duty_project/feature/blocs/authenticate/login/bloc/login_bloc.dart';
import 'package:cleaning_duty_project/feature/blocs/authenticate/logout/bloc/logout_bloc.dart';
import 'package:cleaning_duty_project/feature/blocs/authenticate/register/bloc/register_bloc.dart';
import 'package:cleaning_duty_project/feature/blocs/home/home/home_bloc.dart';
import 'package:cleaning_duty_project/feature/blocs/profile/bloc/profile_bloc.dart';
import 'package:cleaning_duty_project/feature/data/db/secure_storage.dart';
import 'package:cleaning_duty_project/feature/data/remote/authenticate/authenticate_network_client.dart';
import 'package:cleaning_duty_project/feature/data/remote/profile/profile_network_client.dart';
import 'package:cleaning_duty_project/feature/data/repository/authenticate/authenticate.dart';
import 'package:cleaning_duty_project/feature/data/repository/profile/profile.dart';
import 'package:cleaning_duty_project/feature/di/dependency_injection.dart';
import 'package:cleaning_duty_project/feature/routers/screen_route.dart';
import 'package:cleaning_duty_project/feature/screen/authenticate/login/login.dart';
import 'package:cleaning_duty_project/feature/screen/authenticate/register/register.dart';
import 'package:cleaning_duty_project/feature/screen/cleanning_duty/cleanning_duty.dart';
import 'package:cleaning_duty_project/feature/screen/home/home.dart';
import 'package:cleaning_duty_project/feature/screen/profile/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: ScreenRoute.homeScreen,
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      if (ScreenRoute.publicRoute.contains(state.fullPath)) {
        return null;
      }
      final secureStorage = SecureStorageImpl();
      final accessToken = await secureStorage.getAccessToken();

      if (accessToken != null) {
        return null;
      } else {
        return ScreenRoute.loginScreen;
      }
    },
    routes: [
      GoRoute(
        path: ScreenRoute.loginScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => LoginBloc(
            AuthenticationRepositoryImpl(
              authenticateNetworkClient: locator<AuthenticateNetworkClient>(),
            ),
          ),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: ScreenRoute.registerScreen,
        builder: (context, state) => BlocProvider(
          create: (context) {
            return RegisterBloc(
              AuthenticationRepositoryImpl(
                authenticateNetworkClient: locator<AuthenticateNetworkClient>(),
              ),
            );
          },
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: ScreenRoute.homeScreen,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider<HomeBloc>(
              create: (context) => HomeBloc(),
            ),
            BlocProvider<LogoutBloc>(
              create: (context) => LogoutBloc(
                AuthenticationRepositoryImpl(
                  authenticateNetworkClient:
                      locator<AuthenticateNetworkClient>(),
                ),
              ),
            ),
          ],
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: ScreenRoute.profileScreen,
        builder: (context, state) => BlocProvider(
          create: (context) {
            return ProfileBloc(
              ProfileRepositoryImpl(
                profileNetworkClient: locator<ProfileNetworkClient>(),
              ),
            );
          },
          child: const ProfileScreen(),
        ),
      ),
      GoRoute(
          path: ScreenRoute.cleanningDutyScreen,
          builder: (context, state) => const CleanningDuty()),
    ],
  );
  static GoRouter get router => _router;
}
