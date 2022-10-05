import "package:com_nicodevelop_boilerplate/components/authentication/signup/authentication_signup_display_name_component.dart";
import "package:com_nicodevelop_boilerplate/components/authentication/signup/authentication_signup_email_password_component.dart";
import "package:com_nicodevelop_boilerplate/config/constants.dart";
import "package:com_nicodevelop_boilerplate/screens/home_screen.dart";
import "package:com_nicodevelop_boilerplate/services/create_account/create_account_bloc.dart";
import "package:com_nicodevelop_boilerplate/utils/notifications.dart";
import "package:com_nicodevelop_boilerplate/utils/translate.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final PageController _pageController = PageController();

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
          body: Padding(
            padding: const EdgeInsets.all(
              kDefaultPadding,
            ),
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                AuthenticationSignupDisplayNameComponent(
                  controller: _displayNameController,
                  onNext: () async {
                    _unfocus();

                    if (_displayNameController.text.length > 2) {
                      _pageController.nextPage(
                        duration: const Duration(
                          milliseconds: 1,
                        ),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
                AuthenticationSignupEmailPasswordComponent(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  onNext: () {
                    _unfocus();

                    if (_emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                      context.read<CreateAccountBloc>().add(
                            OnCreateAccountEvent(
                              displayName: _displayNameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
