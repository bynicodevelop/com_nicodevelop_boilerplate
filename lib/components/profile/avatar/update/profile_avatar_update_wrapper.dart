import "package:com_nicodevelop_boilerplate/components/profile/avatar/update/profile_update_avatar_button_component.dart";
import "package:com_nicodevelop_boilerplate/utils/notifications.dart";
import "package:com_nicodevelop_boilerplate/utils/translate.dart";
import "package:flutter/material.dart";

class ProfileAvatarUpdateWrapper extends StatelessWidget {
  final Widget child;
  final Function onAvatarUpdated;

  const ProfileAvatarUpdateWrapper({
    super.key,
    required this.child,
    required this.onAvatarUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: ProfileUpdateAvatarButtonComponent(
            onAvatarUpdated: () {
              sendNotificaton(
                context,
                t(context)!.avatar_image_update_success_title,
                t(context)!.avatar_image_update_success_title,
              );

              onAvatarUpdated();
            },
            onAvatarUpdateError: (code) {
              sendNotificaton(
                context,
                t(context)!.upload_file_error_title,
                t(context)!.upload_file_error_description,
              );
            },
          ),
        ),
      ],
    );
  }
}
