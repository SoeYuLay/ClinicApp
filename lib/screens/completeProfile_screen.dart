import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/models/gender.dart';
import 'package:flutter_clinic_app/screens/successCreateAcc_screen.dart';
import 'package:flutter_clinic_app/utils/constants/app_colors.dart';
import 'package:flutter_clinic_app/widgets/genderCard.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/registerController.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  List<Gender> genders = [];
  int? selectedDay;
  int? selectedMonth;
  int? selectedYear;
  File? _pickedImage;
  List<String> monthList = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'];

  @override
  void initState() {
    super.initState();
    genders.add(Gender(type: "MALE", iconData: Icons.male, isSelected: false));
    genders
        .add(Gender(type: "FEMALE", iconData: Icons.female, isSelected: false));
  }

  String getSelectedGender(){
    final selectedGender = genders.firstWhere(
          (g) => g.isSelected,
    );
    return selectedGender.type;
  }

  Future<void> _pickImage(ImageSource source) async{
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  Future<dynamic> _showImageSourceOptions(){
    return showModalBottomSheet(
      backgroundColor: AppColor.bgColor,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Photo Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final registerController = Get.find<RegisterController>();
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              registerController.previousPage();
                              Get.back();
                            },
                            icon: const Icon(Icons.arrow_circle_left_outlined,
                                size: 35),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Obx(() => ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: LinearProgressIndicator(
                                    value: registerController.progress / 4.0,
                                    minHeight: 5,
                                    backgroundColor: Colors.grey[300],
                                    color: AppColor.primaryColor,
                                  ),
                                )),
                          )
                        ],
                      ),
                      Divider(),
                      const Text(
                        'Complete Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Please complete your personal information, your data will not be misused.',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    10.0)), //add border radius here
                                child: _pickedImage != null
                                    ? Image.file(
                                  _pickedImage!,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                )
                                    : Image.asset(
                                  'assets/images/avatar.jpg',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Profile picture',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  Text('Upload your image',
                                      style: TextStyle(fontSize: 15)),
                                ],
                              ),
                              Spacer(),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(color: Colors.grey)),
                                ),
                                onPressed: () => _showImageSourceOptions(),
                                child: const Text('Change',
                                    style: TextStyle(fontSize: 15)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('First name',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      TextField(
                        controller: fNameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Enter First Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('Last name',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      TextField(
                        controller: lNameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Enter Last Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('Address',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      TextField(
                        controller: addressController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Enter Address',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('Birthdate',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: DropdownButtonFormField<int>(
                                iconEnabledColor: Colors.transparent,
                                iconDisabledColor: Colors.transparent,
                                decoration: InputDecoration(
                                  labelText: 'Day',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                items: List.generate(31, (index) => index + 1)
                                    .map((day) => DropdownMenuItem(
                                        value: day, child: Text('$day')))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedDay = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: 140,
                              child: DropdownButtonFormField<String>(
                                iconEnabledColor: Colors.transparent,
                                iconDisabledColor: Colors.transparent,
                                decoration: InputDecoration(
                                  labelText: 'Month',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                items: monthList
                                    .map((month) => DropdownMenuItem(
                                        value: month, child: Text(month)))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedMonth = monthList.indexOf(value!)+1;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: 100,
                              child: DropdownButtonFormField<int>(
                                iconEnabledColor: Colors.transparent,
                                iconDisabledColor: Colors.transparent,
                                decoration: InputDecoration(
                                  labelText: 'Year',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                items: List.generate(100, (index) => 2025 - index)
                                    .map((year) => DropdownMenuItem(
                                        value: year, child: Text('$year')))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedYear = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('Gender',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: genders.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  for (var gender in genders) {
                                    gender.isSelected = false;
                                  }
                                  genders[index].isSelected = true;
                                });
                              },
                              child: GenderCard(gender: genders[index]),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryColor,
                            foregroundColor: AppColor.bgColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                          ),
                          onPressed: registerController.isLoading.value
                              ? null
                              : () async {
                                  final dob = "$selectedYear-$selectedMonth-$selectedDay";
                                  final result =
                                      await registerController.completeProfile(
                                          firstName: fNameController.text,
                                          lastName: lNameController.text,
                                          address: addressController.text,
                                          dob: dob,
                                          gender: getSelectedGender(),
                                          profilePic: _pickedImage!);

                                  final body = result['body'];

                                  if (body['success']) {

                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   SnackBar(content: Text(body['message'])),
                                    // );
                                    registerController.nextPage();
                                    Get.to(() => SuccessCreateAccount());
                                  } else {

                                    Get.snackbar(
                                      'Error',
                                      body['message'] ??
                                          'Complete Profile failed',
                                    );
                                  }
                                },
                          child: registerController.isLoading.value
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('Continue',
                                  style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
