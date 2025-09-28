import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/utils/constants/app_colors.dart';
import 'package:flutter_clinic_app/widgets/recentSearches.dart';
import 'package:flutter_clinic_app/widgets/searchSpecialitiesCard.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import '../widgets/circularIconButton.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchDoctorController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    const SizedBox(width: 105),
                    Center(
                      child: Text('Search',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: searchDoctorController,
                  keyboardType: TextInputType.text,
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
                const SizedBox(height: 15),
                Divider(),
                RecentSearches(),
                const SizedBox(height: 15),
                Text('By specialists',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),),
                const SizedBox(height: 15,),
                SearchSpecialitiesCard()
              ],
            ),
          ),
        ),
      )
    );
  }
}
