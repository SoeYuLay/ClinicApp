import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({required this.status, super.key});

  final String status;

  @override
  Widget build(BuildContext context) {
    Color color = Colors.black;
    Color bgColor = Colors.white;
    switch (status){
      case 'COMPLETED':
        color = Colors.grey.shade800;
        bgColor = Colors.grey.shade100;
        break;
      case 'CONFIRMED':
        color = Colors.green.shade800;
        bgColor = Colors.green.shade100;
        break;
      case 'PENDING':
        color = Colors.deepOrangeAccent.shade700;
        bgColor = Colors.deepOrangeAccent.shade100;
        break;
      case 'CANCELLED':
        color = Colors.redAccent.shade700;
        bgColor = Colors.redAccent.shade100;
        break;
    }
    return Chip(
      label: Text(status,style: TextStyle(color: color)),
      backgroundColor: bgColor,
      padding: EdgeInsets.symmetric(horizontal: 1),
      shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.circular(20),
          side: BorderSide(color: Colors.transparent,width: 0)
      ),
    );
  }
}
