import "package:com_nicodevelop_boilerplate/components/inputs/email/email_input_component.dart";
import "package:com_nicodevelop_boilerplate/components/inputs/password/password_input_component.dart";
import "package:com_nicodevelop_boilerplate/components/inputs/text/text_input_component.dart";
import "package:com_nicodevelop_boilerplate/config/constants.dart";
import "package:com_nicodevelop_boilerplate/screens/home_screen.dart";
import "package:com_nicodevelop_boilerplate/services/create_account/create_account_bloc.dart";
import "package:com_nicodevelop_boilerplate/utils/notifications.dart";
import "package:com_nicodevelop_boilerplate/utils/translate.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:validators/validators.dart";

class SignUpScreen extends StatefulWidget {
  final String affiliateCode;

  const SignUpScreen({
    super.key,
    required this.affiliateCode,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _unfocus() {
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      _emailController.text = "john10@domain.tld";
      _passwordController.text = "123456";
    }
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateAccountBloc, CreateAccountState>(
      listener: (context, state) async {
        if (state is CreateAccountSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false,
          );

          return;
        }

        if (state is CreateAccountFailureState) {
          const String title = "Error";
          String message = t(context)!.sign_up_failed_create_account;

          if (state.code == "email-already-in-use") {
            message = t(context)!.sign_up_email_already_in_use;
          }

          if (state.code == "weak-password") {
            message = t(context)!.sign_up_weak_password;
          }

          if (state.code == "invalid-email") {
            message = t(context)!.sign_up_invalid_email;
          }

          if (state.code == "operation-not-allowed") {
            message = t(context)!.sign_up_operation_not_allowed;
          }

          sendNotificaton(
            context,
            title,
            message,
          );
        }
      },
      child: GestureDetector(
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
                  TextInputComponent(
                    isRequire: true,
                    minCharacters: 3,
                    controller: _displayNameController,
                    label: t(context)!.username_label_input,
                    errorText: t(context)!.username_error_text,
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
                      key: const Key("sign_up_button"),
                      onPressed: () {
                        _unfocus();

                        if (isEmail(_emailController.text) &&
                            _passwordController.text.length >= 6 &&
                            _displayNameController.text.length >= 3) {
                          context.read<CreateAccountBloc>().add(
                                OnCreateAccountEvent(
                                  displayName: _displayNameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  affiliateCode: widget.affiliateCode,
                                ),
                              );
                        }
                      },
                      child: Text(t(context)!.sign_up_title),
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
      ),
    );
  }
}
