import "package:com_nicodevelop_boilerplate/components/inputs/email/email_input_component.dart";
import "package:com_nicodevelop_boilerplate/components/inputs/password/password_input_component.dart";
import "package:com_nicodevelop_boilerplate/config/constants.dart";
import "package:com_nicodevelop_boilerplate/screens/authentication/signup_screen.dart";
import "package:com_nicodevelop_boilerplate/screens/home_screen.dart";
import "package:com_nicodevelop_boilerplate/services/login/login_bloc.dart";
import "package:com_nicodevelop_boilerplate/utils/notifications.dart";
import "package:com_nicodevelop_boilerplate/utils/translate.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:validators/validators.dart";

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInState();
}

class _SignInState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _unfocus() {
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      _emailController.text = "john0@domain.tld";
      _passwordController.text = "123456";
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false,
          );

          return;
        }

        if (state is LoginFailureState) {
          sendNotificaton(
            context,
            t(context)!.sign_in_bad_credentials_title,
            t(context)!.sign_in_bad_credentials_message,
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
                    t(context)!.sign_in_title,
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
                          context.read<LoginBloc>().add(
                                OnLoginEvent(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              );
                        }
                      },
                      child: Text(t(context)!.signin_label_button),
                    ),
                  ),
                  TextButton(
                    onPressed: () async => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                        fullscreenDialog: true,
                      ),
                    ),
                    child: Text(t(context)!.no_account_label_button),
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
