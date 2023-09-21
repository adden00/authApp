class UserInfo {
  UserInfo({required this.id, required this.name, required this.email, required this.createdAt});

  final int id;
  final String name;
  final String email;
  final String createdAt;
  final String profilePhotoUrl = "https://ui-avatars.com/api/?background=0D8ABC&color=fff";

  UserInfo.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        email = json["email"],
        createdAt = json["created_at"];

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "created_at": createdAt,
  };
}