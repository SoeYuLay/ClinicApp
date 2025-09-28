import 'package:flutter_clinic_app/models/timeSlotModel.dart';

class DoctorAvailabilityModel {
  final String key;
  final String label;
  final List<TimeSlotModel> timeslot;

  DoctorAvailabilityModel({
    required this.key,
    required this.label,
    required this.timeslot
});

  factory DoctorAvailabilityModel.fromJson(Map<String, dynamic> json){
    var slotsJson = json['slots'] as List? ?? [];
    List<TimeSlotModel> slots = slotsJson.map((slot)=> TimeSlotModel.fromJson(slot)).toList();
    return DoctorAvailabilityModel(
        key: json['key'] ?? '',
        label: json['label'] ?? '',
        timeslot: slots);
  }
}