import "package:com_nicodevelop_boilerplate/components/inputs/email/email_input_component.dart";
import "package:com_nicodevelop_boilerplate/components/inputs/password/password_input_component.dart";
import "package:com_nicodevelop_boilerplate/utils/translate.dart";
import "package:flutter/material.dart";

class AuthenticationSignupEmailPasswordComponent extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function() onNext;

  const AuthenticationSignupEmailPasswordComponent({
    super.key,
    required this.emailController,
    required this.passwordController,
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
              textAlign: TextAlign.center,
            ),
            EmailInputComponent(
              controller: emailController,
              label: t(context)!.email_label_input,
              errorText: t(context)!.email_error_text,
            ),
            PasswordInputComponent(
              controller: passwordController,
              label: t(context)!.password_label_input,
              errorText: t(context)!.password_error_text,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                key: const Key("sign_up_button"),
                onPressed: onNext,
                child: Text(
                  t(context)!.sign_up_title,
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
