import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../utils/constants/app_colors.dart';
import '../../widgets/circularIconButton.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            /// Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircularIconButton(
                    icon: const Icon(Iconsax.arrow_left, color: Colors.black),
                    onPressed: () => Get.back(),
                    borderColor: Colors.grey.shade400,
                  ),
                  const Spacer(),
                  const Text(
                    "About Us",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),

            /// Scrollable body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// App logo or illustration
                    Center(
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.blue.shade50,
                        child: const Icon(Iconsax.hospital, size: 45, color: Colors.blue),
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// Welcome card
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Welcome to Pulse",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Pulse is a healthcare and doctor appointment "
                                  "app designed to simplify healthcare access. We connect "
                                  "patients with trusted healthcare professionals, making "
                                  "appointments, reminders, and teleconsultations easier "
                                  "than ever.",
                              style: TextStyle(fontSize: 15, height: 1.5, ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// Vision Section
                    sectionTitle("Our Vision", Iconsax.eye),
                    sectionCard(
                      "To make quality healthcare accessible for everyone, regardless "
                          "of time or location, by bridging the gap between patients and doctors "
                          "through technology.",
                    ),

                    const SizedBox(height: 20),

                    /// Mission Section
                    sectionTitle("Our Mission", Iconsax.task_square),
                    sectionCard(
                      "• Connect patients with qualified doctors\n"
                          "• Provide secure and smooth appointment booking\n"
                          "• Enable teleconsultations and follow-ups\n"
                          "• Ensure privacy and trust at all times",
                    ),

                    const SizedBox(height: 20),

                    /// What We Offer Section
                    sectionTitle("What We Offer", Iconsax.activity),
                    offerList(),

                    const SizedBox(height: 20),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper widget for section titles with icon
  Widget sectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue, size: 22),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  /// Helper widget for content in card
  Widget sectionCard(String content) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Text(
          content,
          style: const TextStyle(fontSize: 15, height: 1.5),
        ),
      ),
    );
  }

  /// Helper widget for offer list with icons
  Widget offerList() {
    final offers = [
      {"icon": Iconsax.search_normal, "text": "Doctor search by speciality, time & doctor"},
      {"icon": Iconsax.calendar, "text": "Appointment booking & reminders"},
      {"icon": Iconsax.video, "text": "Teleconsultations (if supported)"},
      {"icon": Iconsax.document_text, "text": "Save and Favorite Doctors"},
      // {"icon": Iconsax.notification, "text": "Notifications & follow-ups"},
    ];

    return Column(
      children: offers.map((item) {
        return Card(
          elevation: 1,
          margin: const EdgeInsets.symmetric(vertical: 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: Icon(item["icon"] as IconData, color: Colors.blue),
            title: Text(item["text"] as String),
          ),
        );
      }).toList(),
    );
  }
}
