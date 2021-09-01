class UserModel {
  int id;
  String name;
  String email;
  String username;
  String profilePhotoUrl;
  String accessToken;

  UserModel({
      this.id,
      this.name,
      this.email,
      this.username,
      this.profilePhotoUrl,
      this.accessToken
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    profilePhotoUrl = json['profile_photo_url'];
    accessToken = json['token'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'profile_photo_url': profilePhotoUrl,
      'token': accessToken
    };
  }
}