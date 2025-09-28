import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/widgets/bestDoctorCard.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import '../../utils/constants/app_colors.dart';
import '../../widgets/circularIconButton.dart';

class DoctorsScreen extends StatelessWidget {
  DoctorsScreen({super.key, this.speciality});
  final String? speciality;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        // child: Center(child: Text('hello'),),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration: BoxDecoration(
                    color: AppColor.bgColor,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child:
                  Row(
                    children: [
                      CircularIconButton(
                          icon: Icon(
                            Iconsax.arrow_left,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          borderColor: Colors.grey.shade400),
                      // SizedBox(width: speciality!= null ? 10 : 90),
                      Expanded(child: Text(speciality!=null ? '$speciality Specialists' : 'All Doctors',textAlign: TextAlign.center, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                speciality != null ? BestDoctorCard(speciality: speciality, isHomePage: false) : BestDoctorCard(isHomePage: false,)
              ],
            ),
          ),
        )
      ),
    );
  }
}
