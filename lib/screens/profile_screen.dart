import "package:com_nicodevelop_dotmessenger/components/account/account_delete_button_component.dart";
import "package:com_nicodevelop_dotmessenger/components/inputs/email/email_input_component.dart";
import "package:com_nicodevelop_dotmessenger/components/inputs/password/password_input_component.dart";
import "package:com_nicodevelop_dotmessenger/config/constants.dart";
import "package:com_nicodevelop_dotmessenger/models/user_model.dart";
import "package:com_nicodevelop_dotmessenger/services/update_account/update_account_bloc.dart";
import "package:com_nicodevelop_dotmessenger/utils/notifications.dart";
import "package:com_nicodevelop_dotmessenger/utils/translate.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:validators/validators.dart";

class ProfileScreen extends StatefulWidget {
  final UserModel userModel;

  const ProfileScreen({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _emailController.text = widget.userModel.email;
  }

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateAccountBloc, UpdateAccountState>(
      listener: (context, state) {
        if (state is UpdateAccountLoadingState) return;

        String title = t(context)!.profile_screen_update_success_title;
        String message = t(context)!.profile_screen_update_success_description;

        if (state is UpdateAccountFailureState) {
          final Map<String, dynamic> messages = {
            "email-already-in-use": t(context)!
                .profile_screen_update_email_already_in_user_description,
            "invalid-email":
                t(context)!.profile_screen_update_email_invalid_description,
            "operation-not-allowed": t(context)!
                .profile_screen_update_operation_not_allowed_description,
            "weak-password":
                t(context)!.profile_screen_update_weak_password_description,
            "network-request-failed":
                t(context)!.profile_screen_network_request_failed_description,
          };

          title = t(context)!.profile_screen_update_error_title;
          message = messages[state.code];
        }

        sendNotificaton(
          context,
          title,
          message,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            t(context)!.profile_screen_title,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            kDefaultPadding,
          ),
          child: Column(
            children: [
              EmailInputComponent(
                controller: _emailController,
              ),
              PasswordInputComponent(
                controller: _passwordController,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (!isEmail(_emailController.text) &&
                        _passwordController.text.isEmpty) return;

                    if (!isEmail(_emailController.text)) {
                      sendNotificaton(
                        context,
                        t(context)!.profile_screen_update_error_title,
                        t(context)!
                            .profile_screen_update_email_invalid_description,
                      );

                      return;
                    }

                    context.read<UpdateAccountBloc>().add(
                          OnUpdateAccountEvent(
                            userModel: widget.userModel.copyWith(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          ),
                        );
                  },
                  child: Text(
                    t(context)!.profile_screen_save_button,
                  ),
                ),
              ),
              const SizedBox(
                width: double.infinity,
                child: AccountDeleteButtonComponent(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}