import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/controllers/specialitiesController.dart';
import 'package:flutter_clinic_app/screens/doctor/doctors_screen.dart';
import 'package:flutter_clinic_app/screens/search_screen.dart';
import 'package:flutter_clinic_app/utils/constants/app_colors.dart';
import 'package:flutter_clinic_app/widgets/bestDoctorCard.dart';
import 'package:flutter_clinic_app/widgets/circularIconButton.dart';
import 'package:flutter_clinic_app/widgets/specialitiesCard.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchDoctorController = TextEditingController();
  TextEditingController selectLocationController = TextEditingController();
  List<String> location = ['Yangon','Mandalay','Nay Pyi Taw','Pyin Oo Lwin','Sagaing','Taung Gyi',
    'Kalaw','Pathein','Mawlamyine','Myeik','Dawei'];

  DateTime? selectedDate;
  String? formattedDate;
  @override
  void initState() {
    // TODO: implement initState
    selectedDate = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
    super.initState();
  }


  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.primaryColor, AppColor.bgColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 200,
                        decoration: BoxDecoration(
                            color: AppColor.bgColor,
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: DropdownButtonFormField<String>(
                          iconEnabledColor: Colors.black,
                          iconDisabledColor: Colors.black,
                          style: TextStyle(color: Colors.black,fontSize: 15),
                          icon: Icon(Iconsax.arrow_down_14),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.location),
                            hintText: 'Yangon',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none
                            ),
                          ),
                          items: location.map((city){
                            return DropdownMenuItem(
                                value: city,
                                child: Text(city));
                          }).toList(),

                          onChanged: (value) {},
                        ),
                      ),

                      Spacer(),

                      CircularIconButton(
                          icon: Icon(Iconsax.notification,color: Colors.black),
                          onPressed: (){},
                        borderColor: AppColor.bgColor,)
                    ],
                  ),
                  const SizedBox(height: 10),
                  Card(
                    color: AppColor.bgColor,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: searchDoctorController,
                            readOnly: true,
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
                            onTap: (){
                              Get.to(()=>SearchScreen());
                            },
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: DropdownButtonFormField<String>(
                              iconEnabledColor: Colors.transparent,
                              iconDisabledColor: Colors.transparent,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.location),
                                hintText: 'Select Location',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.shade300), // Enabled border color
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black), // Focused border color
                                ),
                              ),
                              items: location.map((city){
                                return DropdownMenuItem(
                                  value: city,
                                    child: Text(city));
                              }).toList(),
                              onChanged: (value) {},
                            ),
                          ),
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
                                      '$formattedDate',
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
                              onPressed: () {},

                              child: const Text('Find Results', style: TextStyle(fontSize: 18)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    color: AppColor.bgColor,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('All Specialities',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),),
                              Spacer(),
                              TextButton(
                                  onPressed: () => Get.to(()=> SearchScreen()),
                                  child: Text('View All',
                                    style: TextStyle(
                                        color: AppColor.primaryColor,
                                        fontSize: 15
                                    ),)),
                            ],
                          ),
                          SpecialitiesCard()
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    color: AppColor.bgColor,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('Find best doctor',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),),
                              Spacer(),
                              TextButton(
                                  onPressed: ()=>Get.to(()=>DoctorsScreen()),
                                  child: Text('View All',
                                    style: TextStyle(
                                        color: AppColor.primaryColor,
                                        fontSize: 15
                                    ),)),
                            ],
                          ),
                          BestDoctorCard(isHomePage: true)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
