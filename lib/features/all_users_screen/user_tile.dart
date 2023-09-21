
import 'package:flutter/material.dart';
import 'package:flutter_auth/data/auth_repository/auth_repository.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.userInfo});
  final UserInfo userInfo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(userInfo.name),
      subtitle: Text(userInfo.email),
      leading: Image.network(userInfo.profilePhotoUrl),

    );
  }
}
