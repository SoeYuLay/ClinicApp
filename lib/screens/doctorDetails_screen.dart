// import 'package:flutter/material.dart';
// import 'package:flutter_clinic_app/controllers/doctorController.dart';
// import 'package:flutter_clinic_app/screens/bookAppointment_screen.dart';
// import 'package:flutter_clinic_app/utils/constants/app_colors.dart';
// import 'package:flutter_clinic_app/widgets/doctorAvailabilityCard.dart';
// import 'package:flutter_clinic_app/widgets/doctorDetails.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:get/get.dart';
// import '../models/doctor.dart';
// import '../widgets/circularIconButton.dart';
//
// class DoctorDetailScreen extends StatefulWidget {
//   const DoctorDetailScreen({super.key, required this.doctorID});
//   final String doctorID;
//
//   @override
//   State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
// }
//
// class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
//   DateTime? selectedDate;
//   String? selectedSlot;
//
//   late final DoctorController controller;
//   late Future<Doctor> doctorFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = Get.put(DoctorController(), tag: widget.doctorID);
//     controller.fetchDoctorByID(widget.doctorID);
//     doctorFuture = fetchDoctor();
//   }
//
//   Future<Doctor> fetchDoctor() async {
//     await controller.fetchDoctorByID(widget.doctorID);
//     if (controller.errorMessage.isNotEmpty) {
//       throw Exception(controller.errorMessage);
//     }
//     return controller.doctor.value!;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       body: SafeArea(
//         child: FutureBuilder<Doctor?>(
//           future: doctorFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else if (!snapshot.hasData) {
//               return const Center(child: Text('No data found'));
//             }
//
//             final doctor = snapshot.data!;
//             return SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Stack(
//                     children: [
//                       if ((doctor.doctorImage ?? '').isNotEmpty)
//                         Image.network(
//                           doctor.doctorImage,
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                           height: 240,
//                         )
//                       else
//                         Container(
//                           width: double.infinity,
//                           height: 240,
//                           color: Colors.grey.shade300,
//                           child: const Icon(Iconsax.user, size: 48),
//                         ),
//
//                       Positioned(
//                         left: 20,
//                         top: 20,
//                         child: CircularIconButton(
//                           icon: const Icon(Iconsax.arrow_left, color: Colors.black),
//                           onPressed: Get.back,
//                           borderColor: Colors.grey.shade400,
//                         ),
//                       ),
//                       Positioned(
//                         right: 80,
//                         top: 20,
//                         child: CircularIconButton(
//                           icon: const Icon(Iconsax.heart, color: Colors.black),
//                           onPressed: () {},
//                           borderColor: Colors.grey.shade400,
//                         ),
//                       ),
//                       Positioned(
//                         right: 20,
//                         top: 20,
//                         child: CircularIconButton(
//                           icon: const Icon(Iconsax.share, color: Colors.black),
//                           onPressed: () {},
//                           borderColor: Colors.grey.shade400,
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   // Details
//                   Card(
//                     color: Colors.white,
//                     elevation: 1,
//                     margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
//                     child: Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Column(
//                         children: [
//                           Text(
//                             doctor.doctorName,
//                             style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             doctor.doctorSpeciality,
//                             style: TextStyle(fontSize: 20, color: Colors.grey.shade600),
//                           ),
//                           const SizedBox(height: 10),
//                           DoctorDetails(
//                             rating: doctor.doctorRating,
//                             experience: doctor.doctorExperience,
//                             reviewCount: doctor.doctorReviews,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   // About
//                   Card(
//                     color: Colors.white,
//                     elevation: 1,
//                     margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
//                     child: Container(
//                       padding: const EdgeInsets.all(16),
//                       height: 140,
//                       child: Stack(
//                         children: [
//                           ShaderMask(
//                             shaderCallback: (rect) => const LinearGradient(
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                               colors: [Colors.black, Colors.transparent],
//                               stops: [0.7, 1.0], // keep valid range [0..1]
//                             ).createShader(rect),
//                             blendMode: BlendMode.dstIn,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 const Text("About",
//                                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                                 const SizedBox(height: 10),
//                                 Text(
//                                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua...",
//                                   textAlign: TextAlign.justify,
//                                   style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
//                                   maxLines: 3,
//                                   overflow: TextOverflow.fade,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Positioned(
//                             right: 0,
//                             top: -7,
//                             child: TextButton(
//                               onPressed: () {},
//                               child: Text(
//                                 'View All',
//                                 style: TextStyle(color: AppColor.primaryColor, fontSize: 15),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   // Availability (local setState is fine; guard with mounted)
//                   Card(
//                     color: Colors.white,
//                     elevation: 1,
//                     margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: DoctorAvailabilityCard(
//                         doctorAvailability: doctor.doctorAvailability,
//                         onSelectionChanged: (DateTime date, String? slot) {
//                           if (!mounted) return;
//                           setState(() {
//                             selectedDate = date;
//                             selectedSlot = slot;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   // Book button
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColor.primaryColor,
//                           foregroundColor: AppColor.bgColor,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
//                         ),
//                         onPressed: () {
//                           if (selectedDate != null && selectedSlot != null) {
//                             Get.to(() => BookAppointmentScreen(
//                               doctorID: widget.doctorID,
//                               selectedDate: selectedDate!,
//                               selectedSlot: selectedSlot!,
//                             ));
//                           } else {
//                             Get.snackbar("Error", "Please select a date and time slot");
//                           }
//                         },
//                         child: const Text('Book Appointment', style: TextStyle(fontSize: 18)),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         )
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/controllers/doctorController.dart';
import 'package:flutter_clinic_app/screens/bookAppointment_screen.dart';
import 'package:flutter_clinic_app/utils/constants/app_colors.dart';
import 'package:flutter_clinic_app/widgets/doctorAvailabilityCard.dart';
import 'package:flutter_clinic_app/widgets/doctorDetails.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import '../widgets/circularIconButton.dart';

class DoctorDetailScreen extends StatefulWidget {
  const DoctorDetailScreen({Key? key, required this.doctorID}) : super(key: key);
  final String doctorID;

  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  DateTime? selectedDate;
  String? selectedSlot;

  late final DoctorController controller;

  @override
  void initState() {
    super.initState();
    // Use tag to make controller instance unique per doctor
    controller = Get.put(DoctorController(), tag: widget.doctorID);

    // Fetch doctor safely after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchDoctorByID(widget.doctorID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text('Error: ${controller.errorMessage.value}'));
          }

          final doctor = controller.doctor.value;
          if (doctor == null) {
            return const Center(child: Text('No data found'));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // Doctor Image + buttons
                Stack(
                  children: [
                    if ((doctor.doctorImage ?? '').isNotEmpty)
                      Image.network(
                        doctor.doctorImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 240,
                      )
                    else
                      Container(
                        width: double.infinity,
                        height: 240,
                        color: Colors.grey.shade300,
                        child: const Icon(Iconsax.user, size: 48),
                      ),
                    Positioned(
                      left: 20,
                      top: 20,
                      child: CircularIconButton(
                        icon: const Icon(Iconsax.arrow_left, color: Colors.black),
                        onPressed: Get.back,
                        borderColor: Colors.grey.shade400,
                      ),
                    ),
                    Positioned(
                      right: 80,
                      top: 20,
                      child: CircularIconButton(
                        icon: const Icon(Iconsax.heart, color: Colors.black),
                        onPressed: () {},
                        borderColor: Colors.grey.shade400,
                      ),
                    ),
                    Positioned(
                      right: 20,
                      top: 20,
                      child: CircularIconButton(
                        icon: const Icon(Iconsax.share, color: Colors.black),
                        onPressed: () {},
                        borderColor: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Doctor Info
                Card(
                  color: Colors.white,
                  elevation: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          doctor.doctorName,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          doctor.doctorSpeciality,
                          style: TextStyle(
                              fontSize: 20, color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 10),
                        DoctorDetails(
                          rating: doctor.doctorRating,
                          experience: doctor.doctorExperience,
                          reviewCount: doctor.doctorReviews,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // About Section
                Card(
                  color: Colors.white,
                  elevation: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    height: 140,
                    child: Stack(
                      children: [
                        ShaderMask(
                          shaderCallback: (rect) => const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black, Colors.transparent],
                            stops: [0.7, 1.0],
                          ).createShader(rect),
                          blendMode: BlendMode.dstIn,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text("About",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10),
                              Text(
                                doctor.doctorAbout ?? "No description available.",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey.shade600),
                                maxLines: 3,
                                overflow: TextOverflow.fade,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: -7,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'View All',
                              style: TextStyle(
                                  color: AppColor.primaryColor, fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Availability
                Card(
                  color: Colors.white,
                  elevation: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DoctorAvailabilityCard(
                      doctorAvailability: doctor.doctorAvailability,
                      onSelectionChanged: (DateTime date, String? slot) {
                        if (!mounted) return;
                        setState(() {
                          selectedDate = date;
                          selectedSlot = slot;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Book Button
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        foregroundColor: AppColor.bgColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                      ),
                      onPressed: () {
                        if (selectedDate != null && selectedSlot != null) {
                          Get.to(() => BookAppointmentScreen(
                            doctorID: widget.doctorID,
                            // selectedDate: selectedDate!,
                            // selectedSlot: selectedSlot!,
                          ));
                        } else {
                          Get.snackbar(
                              "Error", "Please select a date and time slot");
                        }
                      },
                      child: const Text('Book Appointment',
                          style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}