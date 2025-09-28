import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/controllers/doctorController.dart';
import 'package:flutter_clinic_app/screens/doctorDetails_screen.dart';
import 'package:flutter_clinic_app/widgets/chipCard.dart';
import 'package:get/get.dart';
import 'package:flutter_clinic_app/models/doctor.dart';

class BestDoctorCard extends StatelessWidget {
  final bool isHomePage;
  final DoctorController controller = Get.put(DoctorController());
  final String? speciality;


  BestDoctorCard({Key? key, required this.isHomePage, this.speciality}) : super(key: key) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchDoctors(isHomePage: isHomePage);
    });
  }
  List<Doctor> filteredDoctors = [];

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      // Filter doctors by speciality
      if(isHomePage){
        filteredDoctors = speciality != null
            ? controller.doctorsHomePage.where((d) => d.doctorSpeciality == speciality).toList()
            : controller.doctorsHomePage;
      }else{
        filteredDoctors = speciality != null
            ? controller.allDoctors.where((d) => d.doctorSpeciality == speciality).toList()
            : controller.allDoctors;
      }

      if (filteredDoctors.isEmpty) {
        return Center(child: Text('No doctors found'));
      }

      return ListView.separated(
        itemCount: filteredDoctors.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final doctor = filteredDoctors[index];

          return InkWell(
            onTap: () {
              Get.to(() => DoctorDetailScreen(doctorID: doctor.doctorID));
            },
            child: Card(
              color: Colors.white,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      child: Image.network(
                        doctor.doctorImage,
                        width: 110,
                        height: 110,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor.doctorName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            doctor.doctorSpeciality,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                size: 30,
                                color: Colors.deepOrangeAccent,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '${doctor.doctorRating}',
                                style: const TextStyle(
                                  color: Colors.deepOrangeAccent,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '(${doctor.doctorReviews})',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Available at',
                            style: TextStyle(fontSize: 16),
                          ),
                          Wrap(
                            spacing: 3,
                            children: [
                              ...doctor.doctorAvailability
                                  .take(2)
                                  .map((day) => ChipCard(
                                labelText: day.label,
                                fontsize: 11.5,
                                circularSize: 20,
                              )),
                              if (doctor.doctorAvailability.length > 2)
                                ChipCard(
                                  labelText:
                                  '+${doctor.doctorAvailability.length - 2}',
                                  fontsize: 11.5,
                                  circularSize: 20,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
