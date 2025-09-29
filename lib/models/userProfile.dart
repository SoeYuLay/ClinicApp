
class UserProfile{
  final String userID;
  final String userEmail;
  final String firstName;
  final String lastName;
  final String profilePic;

  UserProfile({required this.userID, required this.userEmail, required this.firstName, required this.lastName, required this.profilePic});

  factory UserProfile.fromJson(Map<String,dynamic> json){
    return UserProfile(
        userID: json['id'] ?? '',
        userEmail: json['email'] ?? '',
        firstName: json['firstName'] ?? '',
        lastName: json['lastName'] ?? '',
        profilePic: json['profilePicUrl'] ?? '');
  }
}