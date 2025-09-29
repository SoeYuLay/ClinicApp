import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/models/appointments.dart';
import 'package:flutter_clinic_app/screens/appointmentDetails_screen.dart';
import 'package:flutter_clinic_app/tempBookingList.dart';
import 'package:flutter_clinic_app/utils/constants/app_colors.dart';
import 'package:flutter_clinic_app/widgets/statusChip.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({super.key});
  
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
    final bookingList = TempBookingList().tempBookingList;
    return SingleChildScrollView(
      child: ListView.separated(
          itemCount: bookingList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 10);
          },
          itemBuilder: (context, index) {
            final booking = bookingList[index];

            return InkWell(
              onLongPress: (){
                // Get.to(()=>AppointmentDetailsScreen(booking: booking));
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
                                  StatusChip(status: booking.status),
                                  Text(
                                    booking.doctor.doctorName,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    booking.doctor.doctorSpeciality,
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
                                      Text(DateFormat('d MMM, y').format(booking.bookingDate),
                                          style: TextStyle(
                                              color: Colors.grey,fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                      const SizedBox(width: 10),
                                      Text('●  ${booking.timeSlot}',
                                          style: TextStyle(
                                              color: Colors.grey,fontWeight: FontWeight.bold, fontSize: 15)),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(
                                        booking.bookingType == 'Video Visit' ? Iconsax.video5
                                            : Iconsax.user_tag,
                                        size: 18,
                                        color: AppColor.primaryColor,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(booking.bookingType,
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
                                child: Image.asset(booking.doctor.doctorImage,
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
}
