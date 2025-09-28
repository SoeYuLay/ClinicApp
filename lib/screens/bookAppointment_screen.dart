import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clinic_app/controllers/doctorController.dart';
import 'package:flutter_clinic_app/screens/appointmentSuccess_screen.dart';
import 'package:flutter_clinic_app/widgets/doctorAvailabilityCard.dart';
import 'package:flutter_clinic_app/widgets/patientTypeCard.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../utils/constants/app_colors.dart';
import '../widgets/circularIconButton.dart';

class BookAppointmentScreen extends StatefulWidget {
  final String doctorID;

  BookAppointmentScreen({
    super.key,
    required this.doctorID,
  });

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  final DoctorController controller = Get.put(DoctorController());

  @override
  void initState() {
    super.initState();
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
          if (doctor == null) return const Center(child: Text('No doctor found'));

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    decoration: BoxDecoration(
                      color: AppColor.bgColor,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircularIconButton(
                          icon: const Icon(Iconsax.arrow_left, color: Colors.black),
                          onPressed: () => Get.back(),
                          borderColor: Colors.grey.shade400,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Review and Book',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        CircularIconButton(
                          icon: const Icon(Iconsax.info_circle, color: Colors.black),
                          onPressed: () {},
                          borderColor: Colors.grey.shade400,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Doctor Info Card
                  Card(
                    color: Colors.white,
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                            child: Image.network(
                              doctor.doctorImage,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 240,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            doctor.doctorName,
                            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            doctor.doctorSpeciality,
                            style: const TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.star_rounded, size: 30, color: Colors.deepOrangeAccent),
                              const SizedBox(width: 5),
                              Text('${doctor.doctorRating}', style: const TextStyle(color: Colors.deepOrangeAccent, fontSize: 16)),
                              const SizedBox(width: 10),
                              Text('● ${doctor.doctorExperience} Year Experience', style: const TextStyle(color: Colors.grey, fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Appointment Details
                  // Card(
                  //   color: Colors.white,
                  //   elevation: 0,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(15.0),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         const Text('Detail appointment', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  //         const SizedBox(height: 10),
                  //         Obx(() {
                  //           return DoctorAvailabilityCard(
                  //             doctorAvailability: doctor.doctorAvailability,
                  //             initialDate: controller.selectedDate.value ?? DateTime.now(),
                  //             initialSlot: controller.selectedSlot.value,
                  //             onSelectionChanged: (date, slot) {
                  //               controller.selectedDate.value = date;
                  //               controller.selectedSlot.value = slot;
                  //             },
                  //           );
                  //         }),
                  //         const SizedBox(height: 10),
                  //         Text('Note', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  //         const SizedBox(height: 10),
                  //         Obx(() {
                  //           return TextField(
                  //             controller: controller.noteController.value,
                  //             decoration: InputDecoration(
                  //               hintText: 'Add note for doctor',
                  //               border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  //             ),
                  //           );
                  //         }),
                  //       ],
                  //     ),
                  //   ),
                  // ),
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
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Detail appointment',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 10),
                            Card(
                              color: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              margin: const EdgeInsets.only(bottom: 0),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                          child: Image.network(doctor.doctorImage,
                                              width: 110, height: 110),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'In Person appointment',
                                              style: TextStyle(fontSize: 17),
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
                                                Text(
                                                    DateFormat('d MMM, y')
                                                        .format(controller.selectedDate.value!),
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15)),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Icon(
                                                  Iconsax.clock5,
                                                  size: 18,
                                                  color: Colors.grey,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                    controller.selectedSlot.value ??
                                                        "Select a slot",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15)),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor: AppColor.bgColor,
                                              side: BorderSide(
                                                  color: Colors.grey.shade300),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(
                                                          40)))),
                                          onPressed: () {
                                            showModalBottomSheet(
                                                backgroundColor:
                                                AppColor.bgColor,
                                                shape:
                                                const RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(
                                                          20)),
                                                ),
                                                isScrollControlled: false,
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return SingleChildScrollView(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                            context)
                                                            .viewInsets
                                                            .bottom,
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                        MainAxisSize.min,
                                                        children: [
                                                          // const SizedBox(height: 20),
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(16.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    icon: Icon(
                                                                        Iconsax
                                                                            .close_circle,
                                                                        size:
                                                                        30)),
                                                                const SizedBox(
                                                                    width: 45),
                                                                const Text(
                                                                  "Book appointment",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                      fontSize:
                                                                      23),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(16, 0,
                                                                16, 0),
                                                            child:
                                                            DoctorAvailabilityCard(
                                                              doctorAvailability: doctor.doctorAvailability,
                                                              // initialDate: controller.selectedDate.value ?? DateTime.now(),
                                                              // initialSlot: controller.selectedSlot.value,
                                                              onSelectionChanged: (date, slot) {
                                                                controller.selectedDate.value = date;
                                                                controller.selectedSlot.value = slot!;
                                                              },
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                16,
                                                                16,
                                                                16,
                                                                40),
                                                            child: SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              child:
                                                              ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                  AppColor
                                                                      .primaryColor,
                                                                  foregroundColor:
                                                                  AppColor
                                                                      .bgColor,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          40)),
                                                                ),
                                                                onPressed: () {
                                                                  if (controller.selectedSlot.value !=
                                                                      null) {
                                                                    Navigator.pop(
                                                                        context);
                                                                  } else {
                                                                    Get.snackbar(
                                                                        "Error",
                                                                        "Please select a date and time slot");
                                                                  }
                                                                },
                                                                child: const Text(
                                                                    'Make Appointment',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        18)),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Text('Change',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black))),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Note',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: controller.noteController.value,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: 'Add note for doctor',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey
                                                  .shade300), // Enabled border color
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors
                                                  .black), // Focused border color
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Patient Details
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
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Detail patient',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Who\'s the patient',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                              child: SizedBox(
                                height: 70,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.patientSelection.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () => controller.updatePatientSelection(index),
                                      child: PatientTypeCard(
                                        isSelected: controller.patientSelection[index],
                                        patientType: index == 0 ? 'Myself' : 'Someone',
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Full name',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 10),

                            TextField(
                              controller: controller.patientNameController.value,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: 'Enter Patient\'s Full Name',
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey
                                          .shade300), // Enabled border color
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                      Colors.black), // Focused border color
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Full name',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 10),
                            IntlPhoneField(
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey
                                          .shade300), // Enabled border color
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                      Colors.black), // Focused border color
                                ),
                              ),
                              initialCountryCode: 'IN',
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(
                                    12), // limit to 12 digits
                                FilteringTextInputFormatter
                                    .digitsOnly, // allow only numbers
                              ],
                              onChanged: (phone) {
                                // print(phone.completeNumber);
                              },
                            ),
                            Row(
                              children: [
                                Obx(() {
                                  return Checkbox(
                                    value: controller.newPatientCheck.value,
                                    onChanged: (val) => controller.newPatientCheck.value = val ?? false,
                                    fillColor: MaterialStateProperty.resolveWith<Color>((states) =>
                                    controller.newPatientCheck.value ? AppColor.primaryColor : Colors.transparent),
                                    shape: const CircleBorder(),
                                    side: BorderSide(color: Colors.grey.shade500, width: 1.0),
                                  );
                                }),
                                Text(
                                  'I\'m a new patient',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      Center(
                          child: Text(
                            'By proceeding,you agree to the',
                            style: TextStyle(fontSize: 18),
                          )),
                      Center(
                          child: Text('Terms and Conditions',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'and ',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text('Privacy Policy',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        foregroundColor: AppColor.bgColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      ),
                      onPressed: () {
                        if (controller.selectedSlot.value != null) {
                          Get.to(() => AppointmentSuccessScreen(
                            doctor: doctor,
                            selectedDate: controller.selectedDate.value!,
                            selectedSlot: controller.selectedSlot.value!,
                          ));
                        } else {
                          Get.snackbar("Error", "Please select a date and time slot");
                        }
                      },
                      child: const Text('Book Now', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

