import "package:com_nicodevelop_boilerplate/components/profile/avatar/profile_avatar_component.dart";
import "package:com_nicodevelop_boilerplate/models/item_discussion_model.dart";
import "package:com_nicodevelop_boilerplate/models/user_model.dart";
import "package:com_nicodevelop_boilerplate/screens/message_screen.dart";
import "package:timeago/timeago.dart" as timeago;
import "package:flutter/material.dart";

class ItemDiscussionComponent extends StatelessWidget {
  final ItemDiscussionModel itemDiscussionModel;
  final UserModel userModel;

  const ItemDiscussionComponent({
    super.key,
    required this.itemDiscussionModel,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return MessageScreen(
            itemDiscussionModel: itemDiscussionModel,
            userModel: userModel,
          );
        }),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      leading: ProfileAvatarComponent(
        radius: 20.0,
        displayName: itemDiscussionModel.from.displayName,
        photoURL: itemDiscussionModel.from.photoURL,
      ),
      title: Text(itemDiscussionModel.from.displayName),
      subtitle: Text(
        itemDiscussionModel.lastMessage,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: SizedBox(
        height: double.infinity,
        child: Text(
          timeago.format(itemDiscussionModel.lastMessageDate),
          style: Theme.of(context).textTheme.caption,
        ),
      ),
    );
  }
}
