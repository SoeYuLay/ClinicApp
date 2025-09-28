import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/models/doctor.dart';
import 'package:flutter_clinic_app/tempDoctorList.dart';
import 'package:flutter_clinic_app/screens/doctorDetails_screen.dart';
import 'package:flutter_clinic_app/widgets/chipCard.dart';
import 'package:get/get.dart';

class SpecialistCard extends StatelessWidget {
  const SpecialistCard({super.key});

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
          };

          final doctorList = snapshot.data!;
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

                  return InkWell(
                    onLongPress: (){
                      // Get.to(()=>DoctorDetailScreen(doctor: doctor));
                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 0,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          listTileTheme: const ListTileThemeData(
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                                child: Image.asset(doctor.doctorImage,
                                    width: 110, height: 110),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      doctor.doctorName,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      doctor.doctorSpeciality,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 15),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    // const SizedBox(height: 10),
                                    // Row(
                                    //   children: [
                                    //     Icon(
                                    //       Icons.star_rounded,
                                    //       size: 30,
                                    //       color: Colors.deepOrangeAccent,
                                    //     ),
                                    //     const SizedBox(width: 5),
                                    //     Text('${doctor.doctorRating}',
                                    //         style: TextStyle(
                                    //             color: Colors.deepOrangeAccent,
                                    //             fontSize: 18)),
                                    //     const SizedBox(width: 10),
                                    //     Text('(${doctor.doctorReviews})',
                                    //         style: TextStyle(
                                    //             color: Colors.grey, fontSize: 18)),
                                    //   ],
                                    // ),
                                    const SizedBox(height: 10),
                                    Text('Available at',
                                        style: TextStyle(fontSize: 16)),
                                    // const SizedBox(height: 6),
                                    Wrap(
                                      spacing: 3,
                                      children: [
                                        ...doctor.doctorAvailability
                                            .take(2)
                                            .map((day) => ChipCard(labelText: day.label, fontsize: 11.5, circularSize: 20)),
                                        if (doctor.doctorAvailability.length > 2)
                                          ChipCard(labelText: '+${(doctor.doctorAvailability.length-2).toString()}',fontsize: 11.5, circularSize: 20)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          );
        });
  }
}
