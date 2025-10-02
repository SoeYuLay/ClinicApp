import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/controllers/doctorController.dart';
import 'package:flutter_clinic_app/screens/doctor/doctors_screen.dart';
import 'package:flutter_clinic_app/widgets/bestDoctorCard.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../screens/search_screen.dart';
import '../utils/constants/app_colors.dart';

class HomeSearch extends StatefulWidget {
  const HomeSearch({super.key});

  @override
  State<HomeSearch> createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  TextEditingController searchDoctorController = TextEditingController();
  DateTime? selectedDate;
  String? formattedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedDate = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(
        DateTime.now().year - 1,
        DateTime.now().month,
        DateTime.now().day,
      ),
      lastDate: DateTime(
        DateTime.now().year + 1,
        DateTime.now().month,
        DateTime.now().day,
      ),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      color: AppColor.bgColor,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: searchDoctorController,
              // readOnly: true,
              decoration: InputDecoration(
                hintText: 'Search doctor, condition',
                prefixIcon: Icon(Iconsax.search_normal_1),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300), // Enabled border color
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Focused border color
                ),
              ),
              // onTap: (){
              //   Get.to(()=>SearchScreen());
              // },
            ),
            const SizedBox(height: 10),
            // SizedBox(
            //   width: double.infinity,
            //   child: DropdownButtonFormField<String>(
            //     iconEnabledColor: Colors.transparent,
            //     iconDisabledColor: Colors.transparent,
            //     decoration: InputDecoration(
            //       prefixIcon: Icon(Iconsax.location),
            //       hintText: 'Select Location',
            //       enabledBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.grey.shade300), // Enabled border color
            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.black), // Focused border color
            //       ),
            //     ),
            //     items: location.map((city){
            //       return DropdownMenuItem(
            //         value: city,
            //           child: Text(city));
            //     }).toList(),
            //     onChanged: (value) {},
            //   ),
            // ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0))
              ),
              child: Row(
                children: [
                  IconButton(
                    tooltip: 'Tap to open date picker',
                    onPressed: (){
                      selectDate(context);
                    },
                    icon: Icon(Iconsax.calendar_1),),
                  InkWell(
                    child: Text(
                        formattedDate ?? 'Select Date',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFF000000))
                    ),
                    onTap: (){
                      selectDate(context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  foregroundColor: AppColor.bgColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                ),
                onPressed: () => Get.to(()=> DoctorsScreen(searchDoctor: searchDoctorController.text ?? '',searchDate: formattedDate,)),

                child: const Text('Find Results', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
