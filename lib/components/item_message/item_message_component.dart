import "package:com_nicodevelop_dotmessenger/models/item_message_model.dart";
import "package:timeago/timeago.dart" as timeago;
import "package:flutter/material.dart";

class ItemMessageComponent extends StatelessWidget {
  final ItemMessageModel itemMessage;

  const ItemMessageComponent({
    super.key,
    required this.itemMessage,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        leading: const CircleAvatar(
          child: Icon(
            Icons.person,
          ),
        ),
        title: Row(
          children: [
            Text(
              itemMessage.sender,
            ),
            const Spacer(),
            Text(
              timeago.format(itemMessage.createdAt),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        subtitle: Text(itemMessage.message, maxLines: 2),
      ),
    );
  }
}
