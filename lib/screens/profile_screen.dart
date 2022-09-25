import "package:com_nicodevelop_dotmessenger/components/inputs/email/email_input_component.dart";
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
        if (state is UpdateAccountFailureState) {
          print(state);
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

          sendNotificaton(
            context,
            t(context)!.profile_screen_update_error_title,
            messages[state.code],
          );
        }
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
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (!isEmail(_emailController.text)) {
                      sendNotificaton(
                        context,
                        "t(context)!.profile_screen_invalid_email",
                        "",
                      );

                      return;
                    }

                    context.read<UpdateAccountBloc>().add(
                          OnUpdateAccountEvent(
                            userModel: widget.userModel.copyWith(
                              email: _emailController.text,
                            ),
                          ),
                        );
                  },
                  child: Text(
                    t(context)!.profile_screen_save_button,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
