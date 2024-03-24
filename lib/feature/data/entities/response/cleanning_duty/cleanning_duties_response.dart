import 'package:cleaning_duty_project/feature/data/entities/response/cleanning_duty/cleanner_response.dart';

class CleaningDutiesResponse {
  int? id;
  String? assignDate;
  String? cleaningDate;
  Cleaner? cleaner;
  String? createdAt;
  String? updatedAt;

  CleaningDutiesResponse(
      {this.id,
      this.assignDate,
      this.cleaningDate,
      this.cleaner,
      this.createdAt,
      this.updatedAt});

  CleaningDutiesResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    assignDate = json['assign_date'];
    cleaningDate = json['cleaning_date'];
    cleaner =
        json['cleaner'] != null ? Cleaner.fromJson(json['cleaner']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['assign_date'] = assignDate;
    data['cleaning_date'] = cleaningDate;
    if (cleaner != null) {
      data['cleaner'] = cleaner!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'CleaningDutiesResponse { id: $id, assignDate: $assignDate, cleaningDate: $cleaningDate, cleaner: $cleaner, createdAt: $createdAt, updatedAt: $updatedAt }';
  }
}
