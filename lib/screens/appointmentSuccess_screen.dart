import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/controllers/bottomNavController.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../models/doctor.dart';
import '../utils/constants/app_colors.dart';

class AppointmentSuccessScreen extends StatelessWidget {
  AppointmentSuccessScreen({super.key, required this.doctor, required this.selectedDate, this.selectedSlot});
  final Doctor doctor;
  final DateTime selectedDate;
  final String? selectedSlot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius:
                  const BorderRadius.all(Radius.circular(80.0)),
                  child: Image.asset('assets/images/rightClick.png',
                      width: 150, height: 150),
                ),
                Text(
                  'Your appointment successfully booked',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  color: Colors.white,
                  elevation: 0,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      listTileTheme: const ListTileThemeData(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                            child: Image.asset(
                              doctor.doctorImage,
                              // width: 110, height: 110
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            doctor.doctorName,
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            doctor.doctorSpeciality,
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                            decoration: BoxDecoration(
                              color: AppColor.bgColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Health Counseling',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'In person appointment',
                                      style: TextStyle(
                                          color: Colors.grey.shade700, fontSize: 15),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Iconsax.calendar5,
                                          size: 18,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(DateFormat('d MMM, y').format(selectedDate),
                                            style: TextStyle(
                                                color: Colors.grey,fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                        const SizedBox(width: 10),
                                        Text('●  $selectedSlot',
                                            style: TextStyle(
                                                color: Colors.grey,fontWeight: FontWeight.bold, fontSize: 15)),
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                ClipRRect(
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                                  child: Image.asset(doctor.doctorImage,
                                      width: 70, height: 70),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: AppColor.bgColor,
                                side: BorderSide(
                                    color: Colors.grey.shade300
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(40))
                                )
                            ), onPressed: () { Get.to(()=> BottomNavController()); },
                            child: Text('Back to home',style: TextStyle(fontSize: 18,color: Colors.black)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
