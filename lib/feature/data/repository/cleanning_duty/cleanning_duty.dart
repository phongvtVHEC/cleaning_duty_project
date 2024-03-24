import 'package:cleaning_duty_project/feature/data/entities/response/cleanning_duty/cleanning_duty_response.dart';
import 'package:cleaning_duty_project/feature/data/remote/cleanning_duty/cleanning_duty_network_client.dart';

abstract class ICleanningDutyRepository {
  Future<CleanningDutyResponse> getCleanningDuty(String year, String month);
  Future quickAssignDuties();
}

class CleanningDutyRepositoryImpl extends ICleanningDutyRepository {
  final CleanningDutyNetworkClient cleanningDutyNetworkClient;
  CleanningDutyRepositoryImpl({
    required this.cleanningDutyNetworkClient,
  });
  @override
  Future<CleanningDutyResponse> getCleanningDuty(
      String year, String month) async {
    var response =
        await cleanningDutyNetworkClient.getCleaningDuties(year, month);
    return response;
  }

  @override
  Future quickAssignDuties() async {
    var response = await cleanningDutyNetworkClient.quickAssignDuties();
    return response;
  }
}
