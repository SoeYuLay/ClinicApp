import 'package:flutter/material.dart';

class PatientGuidelineCard extends StatelessWidget {
  const PatientGuidelineCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
    color: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      side: BorderSide(
          color: Color(0xFFE4E4E4)
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    margin: const EdgeInsets.only(bottom: 0),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              'Things you should know before you arrive',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              maxLines: 2,
            ),
            Divider(),
            _guideline('1','Please arrive 15 minutes early, especially if it\'s your first visit'),
            const SizedBox(height:  15),
            _guideline('2','Write down any questions for the doctor and bring them along'),
            const SizedBox(height:  15),
            _guideline('3','Bring necessary documents, like ID and medical details'),
            const SizedBox(height:  15),
            _guideline('4','Inform the clinic in advance if you need to reschedule'),
          ],
        ),
      )
    );
  }

  Widget _guideline(String number,String desc){
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(number,textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(desc,maxLines: 2,style: TextStyle(fontSize: 16))),
      ],
    );
  }
}
