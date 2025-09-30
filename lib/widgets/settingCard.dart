import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/api/auth_services.dart';
import 'package:flutter_clinic_app/screens/onboarding_screen.dart';
import 'package:flutter_clinic_app/screens/setting/aboutUs_screen.dart';
import 'package:flutter_clinic_app/screens/setting/privacyPolicy_screen.dart';
import 'package:flutter_clinic_app/screens/setting/termOfUse_screen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class SettingCard extends StatelessWidget {
  SettingCard({super.key});

  final Map<IconData, String> settingList = {
    Iconsax.setting: 'Settings',
    Iconsax.profile_2user4 :  'About us',
    Iconsax.clipboard_text: 'Terms of use',
    Iconsax.lock_circle : 'Privacy policy',
    Iconsax.logout : 'Logout'
  };

  @override
  Widget build(BuildContext context) {
      return Card(
          color: Colors.white,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'General Setting',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 10),
                _buildCardList(settingList)
              ],
            ),
          ));
  }
}

Widget _buildCardList(Map<IconData, String> items){
  final entries = items.entries.toList();
  return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 3, 16, 3),
        child: Column(children: [
          for (int i = 0; i < entries.length; i++) ...[
            _buildCard(
              iconData: entries[i].key,
              cate: entries[i].value,
            ),
            if (i < entries.length - 1) const Divider(),
          ],
        ]),
      ));
}

Widget _buildCard({required IconData iconData, required String cate}) {
  return InkWell(
    onTap: () async {
      if (cate == 'About us'){
        Get.to(()=>AboutUsScreen());
      }else if (cate == 'Terms of use'){
        Get.to(()=>TermOfUseScreen());
      }else if (cate == 'Privacy policy'){
        Get.to(()=>PrivacyPolicyScreen());
      }else if(cate == 'Logout') {
        await AuthService().logout();
      }
    },
    child: ListTile(
        leading: Icon(
          iconData,
          size: 28,
          color: cate == 'Logout' ? Colors.red : Colors.black,
        ),
        title: Text(cate,style: TextStyle(color: cate == 'Logout' ? Colors.red : Colors.black),),
        trailing: Icon(Iconsax.arrow_right_3,color: cate == 'Logout' ? Colors.red : Colors.black,)),
  );
}