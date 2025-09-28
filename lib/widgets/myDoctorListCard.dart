import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/screens/doctorDetails_screen.dart';
import 'package:flutter_clinic_app/utils/constants/app_colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import '../models/doctor.dart';
import '../tempDoctorList.dart';
import 'circularIconButton.dart';

class MyDoctorListCard extends StatelessWidget {
  const MyDoctorListCard({super.key, this.isSaved});

  final bool? isSaved;

  Future<List<Doctor>> getDoctorList() async {
    await Future.delayed(Duration(milliseconds: 500));
    return TempDoctorList().tempDoctorList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Doctor>>(
        future: getDoctorList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No doctors available'));
          }
          ;

          final doctorList = snapshot.data!;
          // final doctorList = speciality == null ? snapshot.data! :
          // snapshot.data!.where((doctor) => doctor.doctorSpeciality == speciality).toList();

          return SingleChildScrollView(
            child: ListView.separated(
                itemCount: doctorList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10);
                },
                itemBuilder: (context, index) {
                  final doctor = doctorList[index];

                  return Card(
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
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                  child: Image.asset(doctor.doctorImage,
                                      width: double.infinity, height: 180),
                                ),
                                if (isSaved!)
                                  Positioned(
                                    right: 10,
                                    child: CircularIconButton(
                                        icon: Icon(
                                          Iconsax.heart5,
                                          color: Colors.deepOrangeAccent,
                                          size: 28,
                                        ),
                                        onPressed: () {},
                                        borderColor: Colors.grey.shade300),
                                  )
                              ],
                            ),
                            const SizedBox(height: 10),
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
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                children: [
                                  Icon(Iconsax.calendar_tick,
                                      color: Colors.black),
                                  const SizedBox(width: 10),
                                  Text(
                                    '10 total appointments made',
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: AppColor.primaryColor,
                                  // side: BorderSide(
                                  //     color: Colors.grey.shade300
                                  // ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40)))),
                              onPressed: () {
                                // Get.to(()=>DoctorDetailScreen(doctor: doctor))
                              },
                              child: Text(isSaved! ? 'Book Now' : 'Book Again',
                                  style: TextStyle(
                                      fontSize: 18, color: AppColor.bgColor)),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
        });
  }
}
