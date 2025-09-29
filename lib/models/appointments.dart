import 'dart:core';

import 'doctor.dart';

class Appointments{
  final String bookingID;
  final String userID;
  final String doctorID;
  final DateTime appointmentDate;
  final String timeSlot;
  final String appointmentNote;
  final String appointmentFor;
  final String phoneNumber;
  final String appointmentStatus;
  final String appointmentType;
  final bool isPatientNew;
  final DateTime createdAt;
  final DateTime updatedAt;

  Appointments({
    required this.bookingID,
    required this.userID,
    required this.doctorID,
    required this.appointmentDate,
    required this.timeSlot,
    required this.appointmentNote,
    required this.appointmentFor,
    required this.phoneNumber,
    required this.appointmentStatus,
    required this.appointmentType,
    required this.isPatientNew,
    required this.createdAt,
    required this.updatedAt
  });

  factory Appointments.fromJson(Map<String, dynamic> json){
    return Appointments(
        bookingID: json['id'] ?? '',
        userID: json['userId'],
        doctorID: json['doctorId'],
        appointmentDate: json['date'],
        timeSlot: json['time'],
        appointmentNote: json['note'],
        appointmentFor: json['appointmentFor'],
        phoneNumber: json['phoneNumber'],
        appointmentStatus: json['status'],
        appointmentType: json['appointmentType'],
        isPatientNew: json['isPatientNew'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }


}