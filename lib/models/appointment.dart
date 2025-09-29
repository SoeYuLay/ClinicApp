import 'dart:core';
import 'package:flutter_clinic_app/models/doctor.dart';

class Appointment{
  final String bookingID;
  final DateTime appointmentDate;
  final String timeSlot;
  final String appointmentStatus;
  final String appointmentFor;
  final String phoneNumber;
  final String appointmentNote;
  final String appointmentType;
  final AppointmentDoctor doctor;

  Appointment({
    required this.bookingID,
    required this.appointmentDate,
    required this.timeSlot,
    required this.appointmentStatus,
    required this.appointmentFor,
    required this.phoneNumber,
    required this.appointmentNote,
    required this.appointmentType,
    required this.doctor
  });

  factory Appointment.fromJson(Map<String, dynamic> json){
    return Appointment(
        bookingID: json['id'] ?? '',
        appointmentDate: json['date'] ?? '',
        timeSlot: json['time'] ?? '',
        appointmentStatus: json['status'] ?? '',
        appointmentFor: json['appointmentFor'] ?? '',
        phoneNumber: json['phoneNumber'] ?? '',
        appointmentNote: json['note'] ?? '',
        appointmentType: json['appointmentType'] ?? '',
        doctor: AppointmentDoctor.fromJson(json['doctor'] ?? ''),
    );
  }
}

class AppointmentTime{
  final DateTime date;
  final String timeslot;

  AppointmentTime({required this.date, required this.timeslot});

  factory AppointmentTime.fromJson(Map<String, dynamic> json){
    final appointmentDateStr = json['date'] ?? '';
    final appointmentDate = appointmentDateStr.isNotEmpty
        ? DateTime.parse(appointmentDateStr).add(const Duration(hours: 6, minutes: 30))
        : DateTime.now();

    return AppointmentTime(
        date: appointmentDate,
        timeslot: json['time'] ?? '');
  }
}

class AppointmentResponse{
  final String successText;
  final AppointmentDoctor doctor;
  final AppointmentTime appointmentTime;
  final String appointmentType;

  AppointmentResponse({required this.successText, required this.doctor, required this.appointmentTime,required this.appointmentType});

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) {

    return AppointmentResponse(
      successText: json['successText'] ?? '',
      doctor: AppointmentDoctor.fromJson(json['doctor'] ?? {}),
      appointmentTime: AppointmentTime.fromJson(json['appointment'] ?? {}),
      appointmentType: json['type'] == 'IN_PERSON' ? 'In Person' : 'Online'
    );
  }

}