import 'package:cleaning_duty_project/core/constants/constants.dart';
import 'package:cleaning_duty_project/core/networks/network_client.dart';

class DevicesNetworkClient {
  final NetworkClient networkClient;

  DevicesNetworkClient({required this.networkClient});

  Future createDevice(String deviceToken) async {
    final response = await networkClient.invoke(
      Constants.api_create_devices_token,
      requestBody: {'deviceToken': deviceToken},
      RequestType.post,
    );
    return response.statusCode;
  }
}
