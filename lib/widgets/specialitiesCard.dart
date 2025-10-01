import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/controllers/specialitiesController.dart';
import 'package:flutter_clinic_app/screens/doctor/doctors_screen.dart';
import 'package:get/get.dart';

class SpecialitiesCard extends StatelessWidget {
  SpecialitiesCard({super.key});
  final controller = Get.put(SpecialitiesController());

  Widget buttons(String id, String imageName, btnName){

    return InkWell(
      onTap: () => Get.to(()=> DoctorsScreen(specialityID: id, speciality: btnName)),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
            border: Border.all(color: Colors.grey.shade400),
        ),
        child: Column(
          children: [
            // Image.asset(imageName,width: 70,height: 60),
            Image.network(imageName,width: 70,height: 60,
              errorBuilder: (context, error, stackTrance){
                return Image.asset('assets/healthcare.png',width: 70,height: 60);
              },
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 75,
              child: Text(
                btnName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 16,
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
    controller.fetchSpecialities(isHomePage: true);

    return Obx((){
      if(controller.isLoading.value){
        return Center(child: CircularProgressIndicator());
      }
      // if (controller.errorMessage.isNotEmpty) {
      //   return Center(child: Text("Error: ${controller.errorMessage}"));
      // }
      final specialityHomePage = controller.specialitiesHomePage;

      if (specialityHomePage.isEmpty) {
        return Center(child: Text("No data found"));
      }
      return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.8
          ),
          itemCount: controller.specialitiesHomePage.length,
          itemBuilder: (context,index){
            final speciality = controller.specialitiesHomePage[index];
            return buttons(speciality.specialityID, speciality.specialityImage, speciality.specialityName);
          });
    }
    );
  }
}
