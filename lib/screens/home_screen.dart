import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/controllers/specialitiesController.dart';
import 'package:flutter_clinic_app/screens/doctor/doctors_screen.dart';
import 'package:flutter_clinic_app/screens/search_screen.dart';
import 'package:flutter_clinic_app/utils/constants/app_colors.dart';
import 'package:flutter_clinic_app/widgets/bestDoctorCard.dart';
import 'package:flutter_clinic_app/widgets/circularIconButton.dart';
import 'package:flutter_clinic_app/widgets/homeSearch.dart';
import 'package:flutter_clinic_app/widgets/specialitiesCard.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../controllers/profileController.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController selectLocationController = TextEditingController();
  final controller = Get.put(ProfileController());
  // List<String> location = ['Yangon','Mandalay','Nay Pyi Taw','Pyin Oo Lwin','Sagaing','Taung Gyi',
  //   'Kalaw','Pathein','Mawlamyine','Myeik','Dawei'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchUserData();
    });
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
                  Obx((){
                    final image = controller.userDetail.value?.profilePic;
                    return Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(image!),
                          radius: 28,
                        ),
                        const SizedBox(width: 10),
                        Text('Welcome, ${controller.userDetail.value?.firstName}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),

                        Spacer(),

                        CircularIconButton(
                          icon: Icon(Iconsax.notification,color: Colors.black),
                          onPressed: (){},
                          borderColor: AppColor.bgColor,)
                      ],
                    );
                  }),
                  const SizedBox(height: 10),
                  HomeSearch(),
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


// Container(
//   width: 200,
//   decoration: BoxDecoration(
//       color: AppColor.bgColor,
//       borderRadius: BorderRadius.circular(30)
//   ),
//   child: DropdownButtonFormField<String>(
//     iconEnabledColor: Colors.black,
//     iconDisabledColor: Colors.black,
//     style: TextStyle(color: Colors.black,fontSize: 15),
//     icon: Icon(Iconsax.arrow_down_14),
//     decoration: InputDecoration(
//       prefixIcon: Icon(Iconsax.location),
//       hintText: 'Yangon',
//       border: OutlineInputBorder(
//           borderSide: BorderSide.none
//       ),
//     ),
//     items: location.map((city){
//       return DropdownMenuItem(
//           value: city,
//           child: Text(city));
//     }).toList(),
//
//     onChanged: (value) {},
//   ),
// ),