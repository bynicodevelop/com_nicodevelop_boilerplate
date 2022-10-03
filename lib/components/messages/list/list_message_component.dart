import "dart:async";

import "package:com_nicodevelop_dotmessenger/components/messages/bubbles/bubble_message_component.dart";
import "package:com_nicodevelop_dotmessenger/config/constants.dart";
import "package:com_nicodevelop_dotmessenger/models/item_discussion_model.dart";
import "package:com_nicodevelop_dotmessenger/models/user_model.dart";
import "package:com_nicodevelop_dotmessenger/repositories/item_message_model.dart";
import "package:com_nicodevelop_dotmessenger/services/list_message/list_message_bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class ListMessageComponent extends StatefulWidget {
  final ItemDiscussionModel itemDiscussionModel;
  final UserModel userModel;

  const ListMessageComponent({
    Key? key,
    required this.itemDiscussionModel,
    required this.userModel,
  }) : super(key: key);

  @override
  State<ListMessageComponent> createState() => _ListMessageComponentState();
}

class _ListMessageComponentState extends State<ListMessageComponent> {
  final ScrollController _scrollController = ScrollController();

  final ValueNotifier<bool> _isInDeltaNotifier = ValueNotifier<bool>(false);

  // Create debounce method
  void _debounce(
    VoidCallback callback,
    int milliseconds,
  ) {
    Timer? timer;

    if (timer?.isActive ?? false) timer!.cancel();

    timer = Timer(Duration(milliseconds: milliseconds), callback);
  }

  void _scrollListener() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    double delta = 200.0;

    _debounce(() {
      if (maxScroll - currentScroll <= delta) {
        _isInDeltaNotifier.value = true;
      } else {
        _isInDeltaNotifier.value = false;
      }
    }, 200);
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_scrollListener);

    _isInDeltaNotifier.addListener(() {
      if (_isInDeltaNotifier.value) {
        context.read<ListMessageBloc>().add(
              OnListMessageEvent(data: {
                "discussionId": widget.itemDiscussionModel.id,
              }),
            );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListMessageBloc, ListMessageState>(
      bloc: context.read<ListMessageBloc>()
        ..add(
          OnListMessageEvent(data: {
            "discussionId": widget.itemDiscussionModel.id,
          }),
        ),
      builder: (BuildContext context, state) {
        final List<ItemMessageModel> messages =
            (state as ListMessageInitialState).messages;

        return ListView.separated(
          reverse: true,
          controller: _scrollController,
          padding: const EdgeInsets.all(
            kDefaultPadding,
          ),
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int index) {
            final ItemMessageModel itemMessageModel = messages[index];

            return BubbleMessageComponent(
              itemMessageModel: itemMessageModel,
              isMe: itemMessageModel.from.id == widget.userModel.uid,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: kDefaultPadding,
            );
          },
        );
      },
    );
  }
}

extension BottomReachExtension on ScrollController {
  void onBottomReach(VoidCallback callback,
      {double sensitivity = 200.0,
      Duration throttleDuration = const Duration(milliseconds: 200)}) {
    late Timer timer;

    addListener(() {
      // I used the timer to destroy the timer
      timer = Timer(throttleDuration, () => timer.cancel());

      // see Esteban Díaz answer
      final maxScroll = position.maxScrollExtent;
      final currentScroll = position.pixels;

      if (maxScroll - currentScroll <= sensitivity) {
        callback();
      }
    });
  }
}
