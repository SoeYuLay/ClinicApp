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

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      // Filter doctors by speciality
      final filteredDoctors = speciality != null
          ? controller.doctors.where((d) => d.doctorSpeciality == speciality).toList()
          : controller.doctors;

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

// class BestDoctorCard extends StatefulWidget {
//   BestDoctorCard({super.key, this.speciality, required this.isHomePage});
//   final String? speciality;
//   final bool isHomePage;
//
//   @override
//   State<BestDoctorCard> createState() => _BestDoctorCardState();
// }
//
// class _BestDoctorCardState extends State<BestDoctorCard> {
//   final controller = Get.put(DoctorController());
//   late Future<List<Doctor>> futureDoctors;
//   late ScrollController _scrollController;
//   List<Doctor> allDoctors = [];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     futureDoctors = widget.isHomePage ? controller.fetchDoctorsHomePage(isHomePage: true) : controller.fetchAllDoctors(isHomePage: false);
//
//     _scrollController = ScrollController();
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels >=
//           _scrollController.position.maxScrollExtent - 100 &&
//           controller.hasMore.value) {
//         // load more
//         setState(() {
//           controller.page++;
//           futureDoctors =
//               controller.fetchAllDoctors(isHomePage: widget.isHomePage);
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Doctor>>(
//       future: futureDoctors,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           print(snapshot.error);
//           return Center(child: Text("Error: ${snapshot.error}"));
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(child: Text("No doctors available"));
//         }
//
//         final doctorList = widget.speciality == null
//             ? snapshot.data!
//             : snapshot.data!
//             .where((doc) => doc.doctorSpeciality == widget.speciality)
//             .toList();
//
//         return ListView.separated(
//           controller: _scrollController,
//           itemCount: widget.isHomePage ? doctorList.length : doctorList.length + (controller.hasMore.value ? 1 : 0),
//           // itemCount: doctorList.length,
//             shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           separatorBuilder: (BuildContext context, int index) =>
//           const SizedBox(height: 10),
//             itemBuilder: (context, index) {
//               // Show loading indicator at the end
//               if (index == doctorList.length) {
//                 return const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Center(child: CircularProgressIndicator()),
//                 );
//               }
//
//               final doctor = doctorList[index]; // safe now
//
//               return InkWell(
//                 onLongPress: () {
//                   Get.to(() => DoctorDetailScreen(doctorID: doctor.doctorID));
//                 },
//                 child: Card(
//                   color: Colors.white,
//                   elevation: 0,
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         ClipRRect(
//                           borderRadius:
//                           const BorderRadius.all(Radius.circular(10.0)),
//                           child: Image.network(
//                             doctor.doctorImage,
//                             width: 110,
//                             height: 110,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 doctor.doctorName,
//                                 style: const TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 1,
//                               ),
//                               Text(
//                                 doctor.doctorSpeciality,
//                                 style: const TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 15,
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 1,
//                               ),
//                               Row(
//                                 children: [
//                                   const Icon(
//                                     Icons.star_rounded,
//                                     size: 30,
//                                     color: Colors.deepOrangeAccent,
//                                   ),
//                                   const SizedBox(width: 5),
//                                   Text(
//                                     '${doctor.doctorRating}',
//                                     style: const TextStyle(
//                                       color: Colors.deepOrangeAccent,
//                                       fontSize: 18,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 10),
//                                   Text(
//                                     '(${doctor.doctorReviews})',
//                                     style: const TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: 18,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 10),
//                               const Text(
//                                 'Available at',
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                               Wrap(
//                                 spacing: 3,
//                                 children: [
//                                   ...doctor.doctorAvailability
//                                       .take(2)
//                                       .map((day) => ChipCard(
//                                     labelText: day.label,
//                                     fontsize: 11.5,
//                                     circularSize: 20,
//                                   )),
//                                   if (doctor.doctorAvailability.length > 2)
//                                     ChipCard(
//                                       labelText:
//                                       '+${doctor.doctorAvailability.length - 2}',
//                                       fontsize: 11.5,
//                                       circularSize: 20,
//                                     ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }
//         );
//       },
//     );
//   }
// }
