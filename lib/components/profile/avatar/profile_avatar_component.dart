import "package:flutter/material.dart";

class ProfileAvatarComponent extends StatelessWidget {
  final String username;
  final double radius;
  final String url;

  const ProfileAvatarComponent({
    super.key,
    required this.username,
    this.radius = 50,
    this.url = "",
  });

  String _generateInitials(String value) {
    final List<String> words = value.split(" ");

    String initials = "";

    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        initials += words[i][0];
      }
    }

    return initials.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final String initials = _generateInitials(username);

    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey[100],
      backgroundImage: url.isNotEmpty ? NetworkImage(url) : null,
      child: url.isNotEmpty
          ? null
          : Text(
              initials,
              style: TextStyle(
                fontSize: radius * (1.8 / initials.length),
              ),
            ),
    );
  }
}
