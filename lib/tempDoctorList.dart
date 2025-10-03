import 'package:flutter_clinic_app/models/doctor.dart';
import 'package:flutter_clinic_app/models/doctorAvailabilityModel.dart';
import 'package:flutter_clinic_app/models/timeSlotModel.dart';

class TempDoctorList{
  List<Doctor> tempDoctorList = [
    Doctor(
        doctorName: 'Dr.Putri Anggraheni',
        doctorSpeciality: 'Cardiology',
        doctorImage: 'assets/images/onBoarding/onboarding1.png',
        doctorRating: 4.85,
        doctorReviews: 255,
        doctorAvailability: [
          DoctorAvailabilityModel(
              key: 'WED',
              label: 'Wednesday',
              timeslot: [
                TimeSlotModel(
                    slotKey: '11:00',
                    slotLabel: '11:00 am'),
                TimeSlotModel(
                    slotKey: '12:00',
                    slotLabel: '12:00 pm'),
                TimeSlotModel(
                    slotKey: '15:00',
                    slotLabel: '03:00 pm'),
                TimeSlotModel(
                    slotKey: '16:00',
                    slotLabel: '04:00 pm'),
                TimeSlotModel(
                    slotKey: '19:00',
                    slotLabel: '07:00 pm'),
                TimeSlotModel(
                    slotKey: '21:00',
                    slotLabel: '09:00 pm'),
              ]
          ),
          DoctorAvailabilityModel(
              key: 'THU',
              label: 'Thursday',
              timeslot: [
                TimeSlotModel(
                    slotKey: '08:00',
                    slotLabel: '08:00 am'),
                TimeSlotModel(
                    slotKey: '09:00',
                    slotLabel: '09:00 am'),
                TimeSlotModel(
                    slotKey: '10:00',
                    slotLabel: '10:00 am'),
                TimeSlotModel(
                    slotKey: '12:00',
                    slotLabel: '12:00 pm'),
                TimeSlotModel(
                    slotKey: '13:00',
                    slotLabel: '01:00 pm'),
                TimeSlotModel(
                    slotKey: '14:00',
                    slotLabel: '02:00 pm'),
                TimeSlotModel(
                    slotKey: '17:00',
                    slotLabel: '05:00 pm'),
                TimeSlotModel(
                    slotKey: '18:00',
                    slotLabel: '06:00 pm'),
                TimeSlotModel(
                    slotKey: '20:00',
                    slotLabel: '08:00 pm'),
              ]
          ),
          DoctorAvailabilityModel(
              key: 'FRI',
              label: 'Friday',
              timeslot: [
                TimeSlotModel(
                    slotKey: '08:00',
                    slotLabel: '08:00 am'),
                TimeSlotModel(
                    slotKey: '10:00',
                    slotLabel: '10:00 am'),
                TimeSlotModel(
                    slotKey: '14:00',
                    slotLabel: '02:00 pm'),
                TimeSlotModel(
                    slotKey: '16:00',
                    slotLabel: '04:00 pm'),
                TimeSlotModel(
                    slotKey: '18:00',
                    slotLabel: '06:00 pm'),
                TimeSlotModel(
                    slotKey: '19:00',
                    slotLabel: '07:00 pm'),
              ]
          ),
          DoctorAvailabilityModel(
              key: 'SUN',
              label: 'Sunday',
              timeslot: [
                TimeSlotModel(
                    slotKey: '09:00',
                    slotLabel: '09:00 am'),
                TimeSlotModel(
                    slotKey: '12:00',
                    slotLabel: '12:00 pm'),
                TimeSlotModel(
                    slotKey: '14:00',
                    slotLabel: '02:00 pm'),
                TimeSlotModel(
                    slotKey: '17:00',
                    slotLabel: '05:00 pm'),
                TimeSlotModel(
                    slotKey: '18:00',
                    slotLabel: '06:00 pm'),
                TimeSlotModel(
                    slotKey: '19:00',
                    slotLabel: '07:00 pm'),
                TimeSlotModel(
                    slotKey: '20:00',
                    slotLabel: '08:00 pm'),
              ]
          ),
        ],
        doctorExperience: 12, doctorID: '1', doctorAbout: 'hi', isFavorite: false, totalAppointment: 1),
    Doctor(
        doctorName: 'Dr.Alan Smith',
        doctorSpeciality: 'Dermatology',
        doctorImage: 'assets/images/onBoarding/onboarding2.png',
        doctorRating: 4.80,
        doctorReviews: 233,
        doctorAvailability: [
          DoctorAvailabilityModel(
              key: 'SUN',
              label: 'Sunday',
              timeslot: [
                TimeSlotModel(
                    slotKey: '11:00',
                    slotLabel: '11:00 am'),
                TimeSlotModel(
                    slotKey: '12:00',
                    slotLabel: '12:00 pm'),
                TimeSlotModel(
                    slotKey: '15:00',
                    slotLabel: '03:00 pm'),
                TimeSlotModel(
                    slotKey: '16:00',
                    slotLabel: '04:00 pm'),
                TimeSlotModel(
                    slotKey: '19:00',
                    slotLabel: '07:00 pm'),
                TimeSlotModel(
                    slotKey: '21:00',
                    slotLabel: '09:00 pm'),
              ]
          ),
          DoctorAvailabilityModel(
              key: 'WED',
              label: 'Wednesday',
              timeslot: [
                TimeSlotModel(
                    slotKey: '08:00',
                    slotLabel: '08:00 am'),
                TimeSlotModel(
                    slotKey: '09:00',
                    slotLabel: '09:00 am'),
                TimeSlotModel(
                    slotKey: '10:00',
                    slotLabel: '10:00 am'),
                TimeSlotModel(
                    slotKey: '12:00',
                    slotLabel: '12:00 pm'),
                TimeSlotModel(
                    slotKey: '13:00',
                    slotLabel: '01:00 pm'),
                TimeSlotModel(
                    slotKey: '14:00',
                    slotLabel: '02:00 pm'),
                TimeSlotModel(
                    slotKey: '17:00',
                    slotLabel: '05:00 pm'),
                TimeSlotModel(
                    slotKey: '18:00',
                    slotLabel: '06:00 pm'),
                TimeSlotModel(
                    slotKey: '20:00',
                    slotLabel: '08:00 pm'),
              ]
          ),
          DoctorAvailabilityModel(
              key: 'SAT',
              label: 'Saturday',
              timeslot: [
                TimeSlotModel(
                    slotKey: '08:00',
                    slotLabel: '08:00 am'),
                TimeSlotModel(
                    slotKey: '10:00',
                    slotLabel: '10:00 am'),
                TimeSlotModel(
                    slotKey: '14:00',
                    slotLabel: '02:00 pm'),
                TimeSlotModel(
                    slotKey: '16:00',
                    slotLabel: '04:00 pm'),
                TimeSlotModel(
                    slotKey: '18:00',
                    slotLabel: '06:00 pm'),
                TimeSlotModel(
                    slotKey: '19:00',
                    slotLabel: '07:00 pm'),
              ]
          ),
        ],
        doctorExperience: 10, doctorID: '1', doctorAbout: 'hi', isFavorite: true, totalAppointment: 1),
    Doctor(
        doctorName: 'Dr.Aditya Pratama',
        doctorSpeciality: 'Neurology',
        doctorImage: 'assets/images/onBoarding/onboarding3.png',
        doctorRating: 4.75,
        doctorReviews: 120,
        doctorAvailability: [
          DoctorAvailabilityModel(
              key: 'WED',
              label: 'Wednesday',
              timeslot: [
                TimeSlotModel(
                    slotKey: '11:00',
                    slotLabel: '11:00 am'),
                TimeSlotModel(
                    slotKey: '12:00',
                    slotLabel: '12:00 pm'),
                TimeSlotModel(
                    slotKey: '15:00',
                    slotLabel: '03:00 pm'),
                TimeSlotModel(
                    slotKey: '16:00',
                    slotLabel: '04:00 pm'),
                TimeSlotModel(
                    slotKey: '19:00',
                    slotLabel: '07:00 pm'),
                TimeSlotModel(
                    slotKey: '21:00',
                    slotLabel: '09:00 pm'),
              ]
          ),
          DoctorAvailabilityModel(
              key: 'THU',
              label: 'Thursday',
              timeslot: [
                TimeSlotModel(
                    slotKey: '08:00',
                    slotLabel: '08:00 am'),
                TimeSlotModel(
                    slotKey: '09:00',
                    slotLabel: '09:00 am'),
                TimeSlotModel(
                    slotKey: '10:00',
                    slotLabel: '10:00 am'),
                TimeSlotModel(
                    slotKey: '12:00',
                    slotLabel: '12:00 pm'),
                TimeSlotModel(
                    slotKey: '13:00',
                    slotLabel: '01:00 pm'),
                TimeSlotModel(
                    slotKey: '14:00',
                    slotLabel: '02:00 pm'),
                TimeSlotModel(
                    slotKey: '17:00',
                    slotLabel: '05:00 pm'),
                TimeSlotModel(
                    slotKey: '18:00',
                    slotLabel: '06:00 pm'),
                TimeSlotModel(
                    slotKey: '20:00',
                    slotLabel: '08:00 pm'),
              ]
          ),
          DoctorAvailabilityModel(
              key: 'THURS',
              label: 'Thursday',
              timeslot: [
                TimeSlotModel(
                    slotKey: '08:00',
                    slotLabel: '08:00 am'),
                TimeSlotModel(
                    slotKey: '10:00',
                    slotLabel: '10:00 am'),
                TimeSlotModel(
                    slotKey: '14:00',
                    slotLabel: '02:00 pm'),
                TimeSlotModel(
                    slotKey: '16:00',
                    slotLabel: '04:00 pm'),
                TimeSlotModel(
                    slotKey: '18:00',
                    slotLabel: '06:00 pm'),
                TimeSlotModel(
                    slotKey: '19:00',
                    slotLabel: '07:00 pm'),
              ]
          ),
          DoctorAvailabilityModel(
              key: 'SAT',
              label: 'Saturday',
              timeslot: [
                TimeSlotModel(
                    slotKey: '09:00',
                    slotLabel: '09:00 am'),
                TimeSlotModel(
                    slotKey: '12:00',
                    slotLabel: '12:00 pm'),
                TimeSlotModel(
                    slotKey: '14:00',
                    slotLabel: '02:00 pm'),
                TimeSlotModel(
                    slotKey: '17:00',
                    slotLabel: '05:00 pm'),
                TimeSlotModel(
                    slotKey: '18:00',
                    slotLabel: '06:00 pm'),
                TimeSlotModel(
                    slotKey: '19:00',
                    slotLabel: '07:00 pm'),
                TimeSlotModel(
                    slotKey: '20:00',
                    slotLabel: '08:00 pm'),
              ]
          ),
        ],
        doctorExperience: 15, doctorID: '2', doctorAbout: 'hi', isFavorite: false, totalAppointment: 0),
  ];
}