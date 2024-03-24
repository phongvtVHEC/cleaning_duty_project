import 'package:cleaning_duty_project/core/networks/network_client.dart';
import 'package:cleaning_duty_project/feature/data/db/local_client.dart';
import 'package:cleaning_duty_project/feature/data/db/secure_storage.dart';
import 'package:cleaning_duty_project/feature/data/remote/authenticate/authenticate_network_client.dart';
import 'package:cleaning_duty_project/feature/data/remote/cleanning_duty/cleanning_duty_network_client.dart';
import 'package:cleaning_duty_project/feature/data/remote/devices/device_network_client.dart';
import 'package:cleaning_duty_project/feature/data/remote/profile/profile_network_client.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Create one NetworkClient
  final networkClient = NetworkClient(
    dio: Dio(),
    secureStorageImpl: SecureStorageImpl(),
  );

  // Register singleton AuthenticateNetworkClient With GetIt
  locator.registerSingleton<AuthenticateNetworkClient>(
    AuthenticateNetworkClient(
      localClientImpl: LocalClientImpl(),
      secureStorage: SecureStorageImpl(),
      networkClient: networkClient,
    ),
  );

  //  Register singleton ProfileNetworkClient With GetIt
  locator.registerSingleton<ProfileNetworkClient>(
    ProfileNetworkClient(
      localClient: LocalClientImpl(),
      networkClient: networkClient,
    ),
  );

  // Register singleton CleanningDutyNetworkClient With GetIt
  locator.registerSingleton<CleanningDutyNetworkClient>(
    CleanningDutyNetworkClient(
      networkClient: networkClient,
    ),
  );
  locator.registerSingleton<DevicesNetworkClient>(
    DevicesNetworkClient(networkClient: networkClient),
  );
}
