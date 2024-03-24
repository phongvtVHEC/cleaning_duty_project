import 'package:cleaning_duty_project/feature/data/entities/response/cleanning_duty/cleanning_duties_response.dart';

class CleanningDutyResponse {
  List<CleaningDutiesResponse>? cleaningDutiesResponse;

  CleanningDutyResponse({this.cleaningDutiesResponse});

  CleanningDutyResponse.fromJson(Map<String, dynamic> json) {
    if (json['cleaningDutiesResponse'] != null) {
      cleaningDutiesResponse = <CleaningDutiesResponse>[];
      json['cleaningDutiesResponse'].forEach((v) {
        cleaningDutiesResponse!.add(CleaningDutiesResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cleaningDutiesResponse != null) {
      data['cleaningDutiesResponse'] =
          cleaningDutiesResponse!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'CleanningDutyResponse { cleaningDutiesResponse: $cleaningDutiesResponse }';
  }
}
