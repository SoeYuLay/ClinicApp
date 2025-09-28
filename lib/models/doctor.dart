import 'package:flutter_clinic_app/models/doctorAvailabilityModel.dart';

class Doctor{
  final String doctorID;
  final String doctorName;
  final String doctorSpeciality;
  final String doctorImage;
  final double doctorRating;
  final int doctorReviews;
  final String doctorAbout;
  final List<DoctorAvailabilityModel> doctorAvailability;
  final int doctorExperience;

  Doctor({
    required this.doctorID,
    required this.doctorName,
    required this.doctorSpeciality,
    required this.doctorImage,
    required this.doctorRating,
    required this.doctorReviews,
    required this.doctorAbout,
    required this.doctorAvailability,
    required this.doctorExperience,
} );

  factory Doctor.fromJson(Map<String, dynamic> json){
    var timeSlots = json['timeSlots'] as List? ?? [];
    List<DoctorAvailabilityModel> availability = [];

    if(timeSlots.first is String){ // Home Page
      availability = timeSlots.map<DoctorAvailabilityModel>((day){
        return DoctorAvailabilityModel(
            key: day ?? '',
            label: day ?? '',
            timeslot: []);
      }).toList();
    }else {
      availability = timeSlots.map((a)=>DoctorAvailabilityModel.fromJson(a)).toList();
    }

    return Doctor(
        doctorID: json['id'] ?? '',
        doctorName: json['name'] ?? '',
        doctorSpeciality: json['primarySpecialty']?['label'] ?? '',
        doctorImage: json['profilePicUrl'] ?? '',
        doctorRating: (json['overallRating'] ?? 0).toDouble(),
        doctorReviews: json['reviews'] ?? 0,
        doctorAbout: json['about'] ?? '',
        doctorAvailability: availability,
        doctorExperience: json['experience'] ?? 0);
  }

}