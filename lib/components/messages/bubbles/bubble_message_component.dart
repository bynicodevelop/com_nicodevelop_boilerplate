import "package:com_nicodevelop_boilerplate/components/messages/contextual/menu/menu_contextual_message_component.dart";
import "package:com_nicodevelop_boilerplate/config/constants.dart";
import "package:com_nicodevelop_boilerplate/repositories/item_message_model.dart";
import "package:flutter/material.dart";

class BubbleMessageComponent extends StatefulWidget {
  final ItemMessageModel itemMessageModel;
  final bool isMe;

  const BubbleMessageComponent({
    super.key,
    required this.itemMessageModel,
    this.isMe = false,
  });

  @override
  State<BubbleMessageComponent> createState() => _BubbleMessageComponentState();
}

class _BubbleMessageComponentState extends State<BubbleMessageComponent> {
  void _bottomSheed() async => showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(kDefaultPadding),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return const MenuContextualMessageComponant();
        },
      );

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: widget.isMe ? _bottomSheed : null,
        child: Container(
          padding: const EdgeInsets.all(
            kDefaultPadding,
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          decoration: BoxDecoration(
            color: widget.isMe
                ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                : Theme.of(context).colorScheme.secondary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            widget.itemMessageModel.message,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}
