import "package:com_nicodevelop_boilerplate/models/user_model.dart";
import "package:com_nicodevelop_boilerplate/screens/authentication/signin_screen.dart";
import "package:com_nicodevelop_boilerplate/screens/share_affiliate_code_screen.dart";
import "package:com_nicodevelop_boilerplate/services/authentication_status/authentication_status_bloc.dart";
import "package:com_nicodevelop_boilerplate/services/get_affiliate_code/get_affiliate_code_bloc.dart";
import "package:com_nicodevelop_boilerplate/services/logout/logout_bloc.dart";
import "package:com_nicodevelop_boilerplate/utils/translate.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:settings_screen/settings_screen.dart";
import "./about_screen.dart";
import "./profile_screen.dart";

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutBloc, LogoutState>(
      listener: (context, state) async {
        if (state is LogoutSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SignInScreen()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Settings",
          ),
        ),
        body: BlocBuilder<GetAffiliateCodeBloc, GetAffiliateCodeState>(
          bloc: context.read<GetAffiliateCodeBloc>()
            ..add(OnGetAffiliateCodeEvent()),
          builder: (context, state) {
            return settingsScreen([
              {
                "title": t(context)!.setting_item_code_title,
                "subtitle": t(context)!.setting_item_code_description,
                "onTap": () async => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShareAffiliateCodeScreen(
                          code: (state as GetAffiliateCodeInitialState).code,
                        ),
                      ),
                    ),
              },
              {
                "title": t(context)!.setting_item_profile_title,
                "subtitle": t(context)!.setting_item_profile_description,
                "onTap": () async {
                  final UserModel userModel = (context
                          .read<AuthenticationStatusBloc>()
                          .state as AuthenticatedStatusState)
                      .userModel;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                        userModel: userModel,
                      ),
                    ),
                  );
                },
              },
              {
                "title": t(context)!.setting_item_about_title,
                "subtitle": t(context)!.setting_item_about_description,
                "onTap": () async => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutScreen(),
                      ),
                    ),
              },
              {
                "title": t(context)!.setting_item_logout_title,
                "subtitle": t(context)!.setting_item_logout_description,
                "onTap": () async =>
                    context.read<LogoutBloc>().add(OnLogoutEvent()),
              }
            ]);
          },
        ),
      ),
    );
  }
}
