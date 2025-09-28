import 'doctor.dart';

class Bookings{
  final Doctor doctor;
  final String patientName;
  final DateTime bookingDate;
  final String timeSlot;
  final String status;
  final String bookingType;
  final String bookingDesc;

  Bookings({
    required this.doctor,
    required this.patientName,
    required this.bookingDate,
    required this.timeSlot,
    required this.status,
    required this.bookingType,
    required this.bookingDesc
});
}