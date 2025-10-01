import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/screens/doctor/doctors_screen.dart';
import 'package:get/get.dart';
import '../controllers/specialitiesController.dart';


class SearchSpecialitiesCard extends StatefulWidget {
  SearchSpecialitiesCard({super.key});

  @override
  State<SearchSpecialitiesCard> createState() => _SearchSpecialitiesCardState();
}

class _SearchSpecialitiesCardState extends State<SearchSpecialitiesCard> {
  final SpecialitiesController controller = Get.put(SpecialitiesController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchSpecialities(isHomePage: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      if (controller.allSpecialities.isEmpty) {
        return Center(child: Text('No specialities found'));
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: controller.allSpecialities.length,
        itemBuilder: (context, index) {
          final speciality = controller.allSpecialities[index];
          return buttons(speciality.specialityID, speciality.specialityImage, speciality.specialityName);
        },
      );
    });
  }

  Widget buttons(String id, String imageName, String btnName) {
    return InkWell(
      onTap: () => Get.to(() => DoctorsScreen(specialityID: id, speciality: btnName)),
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
              errorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/healthcare.png', width: 70, height: 60);
              },
            ),
            SizedBox(width: 10),
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
}

