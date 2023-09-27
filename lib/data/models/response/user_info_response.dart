class UserInfo {
  UserInfo({required this.id, required this.name, required this.email, required this.createdAt});

  final int id;
  final String name;
  final String email;
  final String createdAt;
  final String profilePhotoUrl = "http://bishelp.ru/sites/default/files/imagecache/avatar-list/user/main/780-7804962_cartoon-avatar-png-image-transparent-avatar-user-image.png";

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