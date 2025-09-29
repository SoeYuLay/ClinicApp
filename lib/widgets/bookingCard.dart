import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/controllers/appointmentController.dart';
import 'package:flutter_clinic_app/utils/constants/app_colors.dart';
import 'package:flutter_clinic_app/widgets/statusChip.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../screens/appointmentDetails_screen.dart';

class BookingCard extends StatefulWidget {
  BookingCard({super.key});

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  final controller = Get.put(AppointmentController());

  Widget bookingButton(IconData icon, String text){
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          iconColor: Colors.black,
          backgroundColor: AppColor.bgColor,
          side: BorderSide(
              color: Colors.grey.shade300
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40))
          ),

        ),
        onPressed: (){},
        icon: Icon(icon),
        label: Text(text,style: TextStyle(fontSize: 18,color: Colors.black)));
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      if(controller.isLoading.value){
        return Center(child: CircularProgressIndicator());
      }
      if (controller.errorMessage.isNotEmpty) {
        return Center(child: Text("Error: ${controller.errorMessage}"));
      }
      if (controller.appointmentsList.isEmpty) {
        return Center(child: Text("No data found"));
      }

      return SingleChildScrollView(
        child: ListView.separated(
            itemCount: controller.appointmentsList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 10);
            },
            itemBuilder: (context, index) {
              final appointment = controller.appointmentsList[index];

              return InkWell(
                onLongPress: (){
                  // Get.to(()=>AppointmentDetailsScreen(bookingID: appointment.bookingID));
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
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StatusChip(status: appointment.appointmentStatus),
                                    Text(
                                      appointment.doctor.name,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      appointment.doctor.speciality,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 15),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(
                                          Iconsax.calendar5,
                                          size: 18,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(DateFormat('d MMM, y').format(appointment.appointmentDate),
                                            style: TextStyle(
                                                color: Colors.grey,fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                        const SizedBox(width: 10),
                                        Text('●  ${appointment.timeSlot}',
                                            style: TextStyle(
                                                color: Colors.grey,fontWeight: FontWeight.bold, fontSize: 15)),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(
                                          appointment.appointmentType == 'Online' ? Iconsax.video5
                                              : Iconsax.user_tag,
                                          size: 18,
                                          color: AppColor.primaryColor,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(appointment.appointmentType,
                                            style: TextStyle(
                                                color: AppColor.primaryColor,fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                      ],
                                    )
                                  ],
                                ),
                                Spacer(),
                                ClipRRect(
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                                  child: Image.network(appointment.doctor.imageUrl,
                                      width: 110, height: 110),
                                ),
                              ]
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(child: bookingButton(Iconsax.message, 'Message')),
                              const SizedBox(width: 10,),
                              Expanded(child: bookingButton(Icons.call, 'Call doctor'))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      );
    }
    );
  }
}
