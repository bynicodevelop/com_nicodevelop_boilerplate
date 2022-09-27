import "package:com_nicodevelop_dotmessenger/components/profile/avatar/update/profile_update_avatar_button_component.dart";
import "package:flutter/material.dart";

class ProfileAvatarUpdateWrapper extends StatelessWidget {
  final Widget child;

  const ProfileAvatarUpdateWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
        const Positioned(
          bottom: 0,
          right: 0,
          child: ProfileUpdateAvatarButtonComponent(),
        ),
      ],
    );
  }
}
