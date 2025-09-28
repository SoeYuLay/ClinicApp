import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/utils/constants/app_colors.dart';

class DoctorDetails extends StatelessWidget {
  const DoctorDetails({super.key, required this.rating, required this.experience, required this.reviewCount});
  final double rating;
  final int experience;
  final int reviewCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildColumnCard(rating.toString(), "Ratings"),
          _divider(),
          _buildColumnCard(experience.toString(), "Experience"),
          _divider(),
          _buildColumnCard(reviewCount.toString(), "Reviews")
        ],
      ),
    );
  }

  Widget _buildColumnCard(String value, String label){
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade600
          ),
        )
      ],
    );
  }

  Widget _divider(){
    return Container(
      height: 30,
      width: 1,
      color: Colors.grey.shade400,
      margin: EdgeInsets.symmetric(horizontal: 12),
    );
  }
}
