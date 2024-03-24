import 'package:cleaning_duty_project/feature/data/remote/devices/device_network_client.dart';

abstract class IDevicesRepository {
  Future createDevice(String deviceToken);
}

class DevicesRepositoryImpl extends IDevicesRepository {
  final DevicesNetworkClient devicesNetworkClient;
  DevicesRepositoryImpl({
    required this.devicesNetworkClient,
  });
  @override
  Future createDevice(String deviceToken) async {
    var response = await devicesNetworkClient.createDevice(deviceToken);
    return response;
  }
}
