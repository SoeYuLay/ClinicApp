class SpecialitiesModel {
  final String specialitiesName;
  final String specialitiesImage;

  SpecialitiesModel({
    required this.specialitiesName,
    required this.specialitiesImage
});

  factory SpecialitiesModel.fromJson(Map<String, dynamic> json){
    return SpecialitiesModel(
        specialitiesName: json['label'] ?? '',
        specialitiesImage: json['picUrl'] ?? '');
  }
}