import 'package:cleaning_duty_project/core/constants/constants.dart';
import 'package:cleaning_duty_project/core/networks/network_client.dart';
import 'package:cleaning_duty_project/feature/data/entities/response/cleanning_duty/cleanning_duty_response.dart';

class CleanningDutyNetworkClient {
  final NetworkClient networkClient;

  CleanningDutyNetworkClient({required this.networkClient});

  Future<CleanningDutyResponse> getCleaningDuties(
      String year, String month) async {
    final response = await networkClient.invoke(
      '${Constants.api_getCleaningDuties}/$year/$month',
      RequestType.get,
    );
    return CleanningDutyResponse.fromJson(response.data);
  }

  Future quickAssignDuties() async {
    final response = await networkClient.invoke(
      Constants.api_quickAssignDuties,
      RequestType.post,
    );
    return response.statusCode;
  }
}
