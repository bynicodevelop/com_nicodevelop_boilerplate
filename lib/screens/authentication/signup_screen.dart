import "package:com_nicodevelop_dotmessenger/components/inputs/email/email_input_component.dart";
import "package:com_nicodevelop_dotmessenger/components/inputs/password/password_input_component.dart";
import "package:com_nicodevelop_dotmessenger/config/constants.dart";
import "package:com_nicodevelop_dotmessenger/utils/translate.dart";
import "package:flutter/material.dart";
import "package:validators/validators.dart";

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _unfocus() {
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _unfocus,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(
              kDefaultPadding,
            ),
            child: Column(
              children: [
                Text(
                  t(context)!.sign_up_title,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                EmailInputComponent(
                  controller: _emailController,
                  label: t(context)!.email_label_input,
                  errorText: t(context)!.email_error_text,
                ),
                PasswordInputComponent(
                  controller: _passwordController,
                  label: t(context)!.password_label_input,
                  errorText: t(context)!.password_error_text,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _unfocus();

                      if (isEmail(_emailController.text) &&
                          _passwordController.text.length >= 6) {
                        print("Email: ${_emailController.text}");
                        print("Password: ${_passwordController.text}");
                      }
                    },
                    child: Text(t(context)!.signin_label_button),
                  ),
                ),
                TextButton(
                  onPressed: () async => Navigator.pop(context),
                  child: Text(t(context)!.got_to_signin_label_button),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
