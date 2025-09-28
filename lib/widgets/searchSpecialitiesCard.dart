import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/screens/doctor/doctors_screen.dart';
import 'package:flutter_clinic_app/tempSpecialitiesList.dart';
import 'package:get/get.dart';

import '../controllers/specialitiesController.dart';

class SearchSpecialitiesCard extends StatelessWidget {
  SearchSpecialitiesCard({super.key});
  final controller = Get.put(SpecialitiesController());

  Widget buttons (String imageName,String btnName){
    return InkWell(
      onTap: () => Get.to(()=>DoctorsScreen(speciality: btnName)),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Row(
          children: [
            Image.network(
              imageName,
              width: 70,
              height: 60,
              errorBuilder: (context, error, stackTrance){
              return Image.asset('assets/healthcare.png',width: 70,height: 60);
              },
            ),

            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Text(
                btnName,
                style: TextStyle(
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchSpecialities(isHomePage: false);

    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10
        ),
        itemCount: controller.specialities.length,
        itemBuilder: (context,index){
          final speciality = controller.specialities[index];

          return buttons(speciality.specialitiesImage, speciality.specialitiesName);
        });
  }
}
