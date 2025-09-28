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
import '../models/doctor.dart';
import '../utils/constants/app_colors.dart';
import '../widgets/circularIconButton.dart';

class BookAppointmentScreen extends StatefulWidget {
  BookAppointmentScreen(
      {super.key,
      required this.doctorID,
      required this.selectedDate,
      required this.selectedSlot});
  final String doctorID;
  late DateTime selectedDate;
  late String? selectedSlot;

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  TextEditingController noteController = TextEditingController();
  List<bool> patientSelection = [true, false];
  bool newPatientCheck = false;

  late final DoctorController controller;
  late DateTime selectedDate;
  String? selectedSlot;
  late Future<Doctor> doctorFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedDate = widget.selectedDate;
    selectedSlot = widget.selectedSlot;

    controller = Get.put(DoctorController(), tag: widget.doctorID);
    // controller.fetchDoctorByID(widget.doctorID);
    doctorFuture = fetchDoctor();
  }

  Future<Doctor> fetchDoctor() async {
    await controller.fetchDoctorByID(widget.doctorID);
    if (controller.errorMessage.isNotEmpty) {
      throw Exception(controller.errorMessage);
    }
    return controller.doctor.value!;
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
            child: FutureBuilder<Doctor?>(
              future: doctorFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No data found'));
                }

                final doctor = snapshot.data!;

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  const SizedBox(width: 10),
                                  Text('Review and Book',
                                      style: TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 10),
                                  CircularIconButton(
                                      icon: Icon(
                                        Iconsax.info_circle,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {},
                                      borderColor: Colors.grey.shade400),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
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
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(10.0)),
                                    child: Image.network(
                                      doctor.doctorImage,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 240,
                                    )
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
                                    style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star_rounded,
                                        size: 30,
                                        color: Colors.deepOrangeAccent,
                                      ),
                                      const SizedBox(width: 5),
                                      Text('${doctor.doctorRating}',
                                          style: TextStyle(
                                              color: Colors.deepOrangeAccent,
                                              fontSize: 16)),
                                      const SizedBox(width: 10),
                                      Text('● ${doctor.doctorExperience}',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 16)),
                                      const SizedBox(width: 5),
                                      Text('Year Experience',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 16)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
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
                                                              .format(widget
                                                              .selectedDate),
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
                                                          widget.selectedSlot ??
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
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
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
                                                                    initialDate: selectedDate,
                                                                    initialSlot: selectedSlot,
                                                                    onSelectionChanged: (DateTime date, String? slot) {
                                                                      if (!mounted)return;
                                                                      setState(() {
                                                                        selectedDate = date;
                                                                        selectedSlot = slot;
                                                                      });
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
                                                                        if (widget
                                                                            .selectedSlot !=
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
                                            controller: noteController,
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
                                          itemCount: 2,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    for (int i = 0;
                                                    i < patientSelection.length;
                                                    i++) {
                                                      patientSelection[i] = i ==
                                                          index;
                                                    }
                                                  });
                                                },
                                                child: PatientTypeCard(
                                                    isSelected:
                                                    patientSelection[index],
                                                    patientType: index == 0
                                                        ? 'Myself'
                                                        : 'Someone'));
                                          }),
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
                                    controller: noteController,
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
                                      Checkbox(
                                        value: newPatientCheck,
                                        onChanged: (value) => setState(() {
                                          newPatientCheck = value!;
                                        }),
                                        fillColor:
                                        MaterialStateProperty.resolveWith<Color>(
                                                (states) {
                                              return newPatientCheck
                                                  ? AppColor.primaryColor
                                                  : Colors.transparent;
                                            }),
                                        shape: CircleBorder(),
                                        side: BorderSide(
                                            color: Colors.grey.shade500, width: 1.0),
                                      ),
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
                            padding: const EdgeInsets.all(30),
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
                                  // Get.to(()=>AppointmentSuccessScreen(doctor: widget.doctor, selectedDate: widget.selectedDate,selectedSlot: widget.selectedSlot));
                                },
                                child: const Text('Book Now',
                                    style: TextStyle(fontSize: 18)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
        ));
  }
}
