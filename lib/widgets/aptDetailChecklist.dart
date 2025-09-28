import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'circularIconButton.dart';

class AppointmentDetailChecklist extends StatelessWidget {
  const AppointmentDetailChecklist({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildChecklist(
            title: 'Complete forms',
            durationText: '3-4 Minute',
            isCompleted: true
        ),
        _buildChecklist(
            title: 'Upload your ID card',
            durationText: 'Less than 2 minute',
            isCompleted: true
        ),
        _buildChecklist(
            title: 'Add medical insurance',
            durationText: '4-5 Minute',
            isCompleted: false
        ),
      ],
    );


  }

  Widget _buildChecklist({
    required String title,
    required String durationText,
    required bool isCompleted
}){
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey.shade300
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 3, 16, 3),
        child: ListTile(
          leading: Icon(
            Icons.check_circle,
            color: isCompleted ? Color(0xFFFA7D66) : Colors.grey,
          ),
          title: Text(title),
          subtitle: Text(durationText),
          trailing: CircularIconButton(
              icon: Icon(
                Iconsax.arrow_right_1,
                color: Colors.black,
                size: 20,
              ),
              onPressed: () {},
              borderColor: Colors.grey.shade400),
        ),
      ),
    );
  }
}
