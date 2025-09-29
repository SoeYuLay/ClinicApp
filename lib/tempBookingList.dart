import 'package:flutter_clinic_app/models/appointment.dart';
import 'package:flutter_clinic_app/tempDoctorList.dart';

import 'models/bookings.dart';

class TempBookingList{
  List<Bookings> tempBookingList = [
    Bookings(
        doctor: TempDoctorList().tempDoctorList[0],
        patientName: 'User 1',
        bookingDate: DateTime(2024, 11, 12),
        timeSlot: '09:00am',
        status: 'Approved',
        bookingType: 'Video Visit',
        bookingDesc: 'Health Counseling',
    ),
    Bookings(
        doctor: TempDoctorList().tempDoctorList[1],
        patientName: 'User 1',
        bookingDate: DateTime(2024, 11, 12),
        timeSlot: '09:00am',
        status: 'Pending Confirmation',
        bookingType: 'In person',
        bookingDesc: 'Health Counseling'
    ),
    Bookings(
        doctor: TempDoctorList().tempDoctorList[2],
        patientName: 'User 1',
        bookingDate: DateTime(2024, 12, 20),
        timeSlot: '09:00am',
        status: 'Completed',
        bookingType: 'Video Visit',
        bookingDesc: 'Health Counseling'
    ),
  ];
}