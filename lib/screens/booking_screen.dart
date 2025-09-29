import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/controllers/appointmentController.dart';
import 'package:flutter_clinic_app/utils/constants/app_colors.dart';
import 'package:flutter_clinic_app/widgets/bookingCard.dart';
import 'package:flutter_clinic_app/widgets/circularIconButton.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  TextEditingController appointmentController = TextEditingController();
  final controller = Get.put(AppointmentController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchAppointments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
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
                      Text('Appointments',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: appointmentController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: 'Search appointment',
                                prefixIcon: Icon(Iconsax.search_normal_1),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: BorderSide(color: Colors.black), // Focused border color
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          CircularIconButton(
                              icon: Icon(Iconsax.setting_4,color: Colors.black,),
                              onPressed: (){},
                              borderColor: Colors.grey.shade400),
                          const SizedBox(width: 10),
                          // CircularIconButton(
                          //     icon: Icon(Iconsax.add,color: Colors.black,),
                          //     onPressed: (){},
                          //     borderColor: Colors.grey.shade400),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                BookingCard()
              ],
            ),
          ),
        )
      )
    );
  }
}
