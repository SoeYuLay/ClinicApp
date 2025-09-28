import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/models/doctorAvailabilityModel.dart';
import 'package:flutter_clinic_app/utils/constants/app_colors.dart';
import 'package:flutter_clinic_app/widgets/chipCard.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../controllers/doctorController.dart';

class DoctorAvailabilityCard extends StatefulWidget {
  const DoctorAvailabilityCard({
    super.key,
    required this.doctorAvailability,
    required this.onSelectionChanged,
  });

  final List<DoctorAvailabilityModel> doctorAvailability;
  final Function(DateTime date, String slotKey, String slotLabel)
      onSelectionChanged;

  @override
  State<DoctorAvailabilityCard> createState() => _DoctorAvailabilityCardState();
}

class _DoctorAvailabilityCardState extends State<DoctorAvailabilityCard> {
  final DoctorController controller = Get.put(DoctorController());

  final List<String> morningSlots = [
    "08:00 AM",
    "09:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 PM"
  ];
  final List<String> afternoonSlots = [
    "01:00 PM",
    "02:00 PM",
    "03:00 PM",
    "04:00 PM",
    "05:00 PM"
  ];
  final List<String> eveningSlots = [
    "06:00 PM",
    "07:00 PM",
    "08:00 PM",
    "09:00 PM"
  ];

  DateTime getSlotDateTime(String slot, DateTime date) {
    final format = DateFormat("hh:mm a");
    final time = format.parseLoose(slot);
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  Widget buildSlotSection(
    String title,
    List<String> sectionSlots,
    List<Map<String, String>> availableSlots,
  ) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: TextStyle(color: Colors.grey.shade600, fontSize: 18)),
      Wrap(
        spacing: 8,
        children: sectionSlots.map((slotLabel) {
          final now = DateTime.now();
          final isToday = controller.selectedDate.value.year == now.year &&
              controller.selectedDate.value.month == now.month &&
              controller.selectedDate.value.day == now.day;

          final slotTime =
              getSlotDateTime(slotLabel, controller.selectedDate.value);

// find matching slot (with key+label) from API
          final matchedSlot = availableSlots.firstWhere(
            (s) => s['label'] == slotLabel,
            orElse: () => {},
          );

          final isAvailable = matchedSlot.isNotEmpty &&
              (isToday ? slotTime.isAfter(now) : true);

          final isSelected = controller.selectedSlotLabel.value == slotLabel;

          return GestureDetector(
            onTap: isAvailable
                ? () {
                    controller.selectedSlotKey.value = matchedSlot['key']!;
                    controller.selectedSlotLabel.value = slotLabel;

                    widget.onSelectionChanged(
                      controller.selectedDate.value,
                      controller.selectedSlotKey.value,
                      controller.selectedSlotLabel.value,
                    );
                  }
                : null,
            child: ChipCard(
              labelText: slotLabel,
              fontsize: 15,
              circularSize: 8,
              isAvailable: isAvailable,
              isSelected: isSelected,
            ),
          );
        }).toList(),
      ),
      const SizedBox(height: 10),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final daysInMonth = DateTime(controller.selectedDate.value.year,
              controller.selectedDate.value.month + 1, 0)
          .day;
      final selectedDay =
          DateFormat('EEE').format(controller.selectedDate.value).toUpperCase();

// available slots with key+label
      final availableSlots = widget.doctorAvailability
          .where((d) => d.key == selectedDay)
          .expand((d) {
        return d.timeslot.map((s) {
          final parsed = DateFormat("h:mm a").parseLoose(s.slotLabel);
          final formatted = DateFormat("hh:mm a").format(parsed);
          return {
            "key": s.slotKey, // API key
            "label": formatted, // formatted label
          };
        });
      }).toList();

      return Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            /// Month Navigation
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          controller.selectedDate.value = DateTime(
                              controller.selectedDate.value.year,
                              controller.selectedDate.value.month - 1,
                              1);
                        },
                        child: Icon(Iconsax.arrow_left_3, size: 30)),
                    Text(
                      DateFormat.yMMMM().format(controller.selectedDate.value),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                        onTap: () {
                          controller.selectedDate.value = DateTime(
                              controller.selectedDate.value.year,
                              controller.selectedDate.value.month + 1,
                              1);
                        },
                        child: Icon(Iconsax.arrow_right_2, size: 30)),
                  ],
                ),
              ),
            ),

            /// Days List
            Container(
              height: 90,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: daysInMonth,
                itemBuilder: (context, index) {
                  final firstDayOfMonth = DateTime(
                      controller.selectedDate.value.year,
                      controller.selectedDate.value.month,
                      1);
                  final date = firstDayOfMonth.add(Duration(days: index));

                  final now = DateTime.now();
                  final today = DateTime(now.year, now.month, now.day);

                  if (date.isBefore(today)) {
                    return const SizedBox.shrink();
                  }

                  final isSelected =
                      date.day == controller.selectedDate.value.day &&
                          date.month == controller.selectedDate.value.month &&
                          date.year == controller.selectedDate.value.year;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        controller.selectedDate.value = date;
                        controller.selectedSlotKey.value = '';
                        controller.selectedSlotLabel.value = '';
                        widget.onSelectionChanged(
                          controller.selectedDate.value,
                          '',
                          '',
                        );
                      });
                    },
                    child: Container(
                      width: 60,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? AppColor.primaryColor
                              : Colors.grey.shade500,
                        ),
                        color:
                            isSelected ? const Color(0xFFEBEEFA) : Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat.E().format(date),
                              style: TextStyle(
                                  color: Colors.grey.shade600, fontSize: 17),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              date.day.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            /// Slots
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSlotSection('Morning', morningSlots, availableSlots),
                  buildSlotSection('Afternoon', afternoonSlots, availableSlots),
                  buildSlotSection('Evening', eveningSlots, availableSlots),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
