import "package:com_nicodevelop_boilerplate/config/constants.dart";
import "package:flutter/material.dart";

class MenuContextualMessageComponant extends StatelessWidget {
  const MenuContextualMessageComponant({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding,
        left: kDefaultPadding,
        right: kDefaultPadding,
        bottom: kDefaultPadding * 3,
      ),
      child: Wrap(
        children: [
          ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.edit,
            ),
            title: const Text("Update"),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.error.withOpacity(0.8),
            ),
            title: Text(
              "Delete",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
