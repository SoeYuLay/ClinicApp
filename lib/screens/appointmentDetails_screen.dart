// import 'package:flutter/material.dart';
// import 'package:flutter_clinic_app/controllers/appointmentController.dart';
// import 'package:flutter_clinic_app/utils/constants/app_colors.dart';
// import 'package:flutter_clinic_app/widgets/aptDetailChecklist.dart';
// import 'package:flutter_clinic_app/widgets/patientGuidelineCard.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import '../models/appointment.dart';
// import '../widgets/circularIconButton.dart';
// import '../widgets/statusChip.dart';
//
// class AppointmentDetailsScreen extends StatefulWidget {
//   const AppointmentDetailsScreen({required this.bookingID,super.key});
//
//   final String bookingID;
//
//   @override
//   State<AppointmentDetailsScreen> createState() => _AppointmentDetailsScreenState();
// }
//
// class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
//   final controller = Get.put(AppointmentController());
//
//   Widget appointmentButtons(IconData iconData, String text){
//     return Column(
//       children: [
//         CircularIconButton(
//             icon: Icon(iconData,color: Colors.black,),
//             onPressed: (){},
//             borderColor: Colors.grey.shade400
//         ),
//         const SizedBox(height: 10),
//         Text(text,style: TextStyle(color: Colors.grey.shade700),)
//       ],
//     );
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.grey.shade100,
//         body: SafeArea(
//             child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//                   decoration: BoxDecoration(
//                     color: AppColor.bgColor,
//                     borderRadius: BorderRadius.circular(20.0),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.05),
//                         blurRadius: 10,
//                         offset: Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           CircularIconButton(
//                               icon: Icon(
//                                 Iconsax.arrow_left,
//                                 color: Colors.black,
//                               ),
//                               onPressed: () {
//                                 Get.back();
//                               },
//                               borderColor: Colors.grey.shade400),
//                           const SizedBox(width: 10),
//                           Text('Appointment Detail',
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold)),
//                           const SizedBox(width: 10),
//                           CircularIconButton(
//                               icon: Icon(
//                                 Iconsax.share,
//                                 color: Colors.black,
//                               ),
//                               onPressed: () {},
//                               borderColor: Colors.grey.shade400),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Card(
//                   color: Colors.white,
//                   elevation: 0,
//                   child: Theme(
//                     data: Theme.of(context).copyWith(
//                       listTileTheme: const ListTileThemeData(
//                         contentPadding:
//                         EdgeInsets.symmetric(horizontal: 0),
//                       ),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(15.0),
//                       child: Column(
//                         children: [
//                           ClipRRect(
//                             borderRadius:
//                             const BorderRadius.all(Radius.circular(10.0)),
//                             child: Image.asset(booking.doctor.doctorImage,
//                               // width: 110, height: 110
//                             ),
//                           ),
//                           const SizedBox(height: 5),
//                           Text(
//                             booking.doctor.doctorName,
//                             style: TextStyle(
//                                 fontSize: 23,
//                                 fontWeight: FontWeight.bold),
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 1,
//                           ),
//                           const SizedBox(height: 3),
//                           Text(
//                             booking.doctor.doctorSpeciality,
//                             style: TextStyle(
//                                 color: Colors.grey, fontSize: 18),
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 1,
//                           ),
//                           const SizedBox(height: 15),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               appointmentButtons(Iconsax.call, 'Call'),
//                               appointmentButtons(Iconsax.message, 'Message'),
//                               appointmentButtons(Iconsax.calendar_add, 'Schedule'),
//                               appointmentButtons(Iconsax.more, 'Detail')
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Card(
//                   color: Colors.white,
//                   elevation: 0,
//                   child: Theme(
//                     data: Theme.of(context).copyWith(
//                       listTileTheme: const ListTileThemeData(
//                         contentPadding:
//                         EdgeInsets.symmetric(horizontal: 0),
//                       ),
//                     ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'About appointment',
//                                 style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold),
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 1,
//                               ),
//                               StatusChip(status: booking.status),
//                               Text(
//                                 booking.bookingDesc,
//                                 style: TextStyle(
//                                     color: Colors.black, fontSize: 18),
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 1,
//                               ),
//                               const SizedBox(height: 5),
//                               Text(
//                                 '${booking.bookingType} appointment',
//                                 style: TextStyle(
//                                     color: Colors.grey.shade700, fontSize: 15),
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 1,
//                               ),
//                               const SizedBox(height: 8),
//                               Row(
//                                 children: [
//                                   Icon(
//                                     Iconsax.calendar5,
//                                     size: 18,
//                                     color: Colors.grey,
//                                   ),
//                                   const SizedBox(width: 5),
//                                   Text(DateFormat('d MMM, y').format(booking.bookingDate),
//                                       style: TextStyle(
//                                           color: Colors.grey,fontWeight: FontWeight.bold,
//                                           fontSize: 15)),
//                                   const SizedBox(width: 10),
//                                   Text('●  ${booking.timeSlot}',
//                                       style: TextStyle(
//                                           color: Colors.grey,fontWeight: FontWeight.bold, fontSize: 15)),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           Spacer(),
//                           ClipRRect(
//                             borderRadius:
//                             const BorderRadius.all(Radius.circular(10.0)),
//                             child: Image.asset(booking.doctor.doctorImage,
//                                 width: 110, height: 110),
//                           ),
//                         ]
//                     ),
//                   ),
//                   )),
//                 const SizedBox(height: 10),
//                 Card(
//                     color: Colors.white,
//                     elevation: 0,
//                     child: Theme(
//                       data: Theme.of(context).copyWith(
//                         listTileTheme: const ListTileThemeData(
//                           contentPadding:
//                           EdgeInsets.symmetric(horizontal: 0),
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(15.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Appointment checklists',
//                               style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold),
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 1,
//                             ),
//                             const SizedBox(height: 10),
//                             AppointmentDetailChecklist()
//                           ],
//                         )
//                       ),
//                     )),
//                 const SizedBox(height: 10),
//                 Card(
//                     color: Colors.white,
//                     elevation: 0,
//                     child: Theme(
//                       data: Theme.of(context).copyWith(
//                         listTileTheme: const ListTileThemeData(
//                           contentPadding:
//                           EdgeInsets.symmetric(horizontal: 0),
//                         ),
//                       ),
//                       child: Padding(
//                           padding: const EdgeInsets.all(15.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Guidelines for patients',
//                                 style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold),
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 1,
//                               ),
//                               const SizedBox(height: 10),
//                               PatientGuidelineCard()
//                             ],
//                           )
//                       ),
//                     )),
//               ],
//             ),
//           ),
//         )));
//   }
// }
