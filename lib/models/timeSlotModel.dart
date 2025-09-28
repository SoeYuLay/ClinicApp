class TimeSlotModel{
  final String slotKey;
  final String slotLabel;

  TimeSlotModel({
    required this.slotKey,
    required this.slotLabel
});

  factory TimeSlotModel.fromJson(Map<String, dynamic> json){
    return TimeSlotModel(
        slotKey: json['key'] ?? '',
        slotLabel: json['label'] ?? '');
  }

}