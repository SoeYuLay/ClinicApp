import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/utils/constants/app_colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import '../../widgets/circularIconButton.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  Widget _buildSection(String title, String content, IconData icon) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColor.primaryColor, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  const SizedBox(height: 6),
                  Text(content,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                          height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircularIconButton(
                      icon: const Icon(
                        Iconsax.arrow_left,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      borderColor: Colors.grey.shade400),
                  const SizedBox(width: 90),
                  const Text('Privacy Policy',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildSection(
                      "Data Collection",
                      "We collect personal information such as your name, contact details, and medical history to provide healthcare services efficiently.",
                      Iconsax.document_text,
                    ),
                    _buildSection(
                      "How We Use Your Data",
                      "Your data is used strictly for booking appointments, managing medical records, and improving user experience.",
                      Iconsax.activity,
                    ),
                    _buildSection(
                      "Third-Party Sharing",
                      "We do not share your personal data with third parties unless required by law or with your explicit consent.",
                      Iconsax.shield_tick,
                    ),
                    _buildSection(
                      "Your Rights",
                      "You have the right to access, update, or request deletion of your personal information at any time.",
                      Iconsax.user_edit,
                    ),
                    _buildSection(
                      "Contact Us",
                      "If you have any questions about our Privacy Policy, please contact our support team at support@dokterian.com.",
                      Iconsax.call,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
