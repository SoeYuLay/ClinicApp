import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../utils/constants/app_colors.dart';
import '../../widgets/circularIconButton.dart';

class TermOfUseScreen extends StatelessWidget {
  const TermOfUseScreen({super.key});

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
                    'Terms of Use',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),

            /// Scrollable Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Intro
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Welcome to Pulse. By using our app, you agree to the following Terms of Use. "
                              "Please read them carefully before proceeding.",
                          style: TextStyle(fontSize: 15, height: 1.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// Section 1
                    sectionTitle("1. Eligibility", Iconsax.user),
                    sectionCard(
                      "You must be at least 18 years old (or the legal age in your country) "
                          "to use this app. If you are using it on behalf of another person, "
                          "you confirm that you are legally authorized to do so.",
                    ),

                    const SizedBox(height: 20),

                    /// Section 2
                    sectionTitle("2. Account & Security", Iconsax.lock),
                    sectionCard(
                      "You are responsible for keeping your account credentials secure. "
                          "Do not share your password with others. Notify us immediately if "
                          "you suspect unauthorized access to your account.",
                    ),

                    const SizedBox(height: 20),

                    /// Section 3
                    sectionTitle("3. Use of Service", Iconsax.activity),
                    sectionCard(
                      "You agree to use the app only for lawful purposes. "
                          "You may not misuse the service, attempt to disrupt our systems, "
                          "or impersonate others while using the app.",
                    ),

                    const SizedBox(height: 20),

                    /// Section 4
                    sectionTitle("4. Medical Disclaimer", Iconsax.health),
                    sectionCard(
                      "Pulse provides a platform to connect patients with healthcare professionals. "
                          "We do not provide medical advice ourselves. Always consult a licensed professional "
                          "before making medical decisions.",
                    ),

                    const SizedBox(height: 20),

                    /// Section 5
                    sectionTitle("5. Limitation of Liability", Iconsax.warning_2),
                    sectionCard(
                      "We are not responsible for outcomes of medical consultations, "
                          "nor for interruptions, errors, or unauthorized access to the service. "
                          "Your use of the app is at your own risk.",
                    ),

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

  /// Section Title with Icon
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

  /// Section Content Card
  Widget sectionCard(String content) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(top: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Text(
          content,
          style: const TextStyle(fontSize: 15, height: 1.5),
        ),
      ),
    );
  }
}
