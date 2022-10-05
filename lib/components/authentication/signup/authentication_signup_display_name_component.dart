import "package:com_nicodevelop_boilerplate/components/inputs/text/text_input_component.dart";
import "package:com_nicodevelop_boilerplate/utils/translate.dart";
import "package:flutter/material.dart";

class AuthenticationSignupDisplayNameComponent extends StatelessWidget {
  final TextEditingController controller;
  final Function() onNext;

  const AuthenticationSignupDisplayNameComponent({
    super.key,
    required this.controller,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              t(context)!.sign_up_title,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            TextInputComponent(
              isRequire: true,
              minCharacters: 3,
              controller: controller,
              label: t(context)!.username_label_input,
              errorText: t(context)!.username_error_text,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                key: const Key("display_name_button"),
                onPressed: onNext,
                child: Text(
                  t(context)!.sign_up_continue_title,
                ),
              ),
            ),
            TextButton(
              onPressed: () async => Navigator.pop(context),
              child: Text(t(context)!.got_to_signin_label_button),
            ),
          ],
        ),
      ),
    );
  }
}
