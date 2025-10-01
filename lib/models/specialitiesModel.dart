class SpecialitiesModel {
  final String specialityName;
  final String specialityImage;
  final String specialityID;

  SpecialitiesModel({
    required this.specialityID,
    required this.specialityName,
    required this.specialityImage
});

  factory SpecialitiesModel.fromJson(Map<String, dynamic> json){
    return SpecialitiesModel(
        specialityID: json['id'] ?? '',
        specialityName: json['label'] ?? '',
        specialityImage: json['picUrl'] ?? '');
  }
}