import "package:com_nicodevelop_dotmessenger/models/user_model.dart";
import "package:com_nicodevelop_dotmessenger/services/authentication_status/authentication_status_bloc.dart";
import "package:com_nicodevelop_dotmessenger/services/update_account/update_account_bloc.dart";
import "package:com_nicodevelop_dotmessenger/services/upload_file/upload_file_bloc.dart";
import "package:com_nicodevelop_dotmessenger/utils/notifications.dart";
import "package:com_nicodevelop_dotmessenger/utils/translate.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:image_picker/image_picker.dart";

class ProfileUpdateAvatarButtonComponent extends StatelessWidget {
  const ProfileUpdateAvatarButtonComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      child: BlocListener<UploadFileBloc, UploadFileState>(
        listener: (context, state) async {
          if (state is UploadFileFailureState) {
            sendNotificaton(
              context,
              t(context)!.upload_file_error_title,
              t(context)!.upload_file_error_description,
            );

            return;
          }

          if (state is UploadFileSuccessState) {
            UserModel userModel = (context
                    .read<AuthenticationStatusBloc>()
                    .state as AuthenticatedStatusState)
                .userModel;

            userModel = userModel.copyWith(
              photoURL: state.photoURL,
            );

            context.read<UpdateAccountBloc>().add(
                  OnUpdateAccountEvent(
                    userModel: userModel,
                  ),
                );
          }
        },
        child: IconButton(
          color: Colors.white,
          onPressed: () async {
            final ImagePicker picker = ImagePicker();

            final XFile? image = await picker.pickImage(
              source: ImageSource.gallery,
            );

            if (image == null) return;

            context.read<UploadFileBloc>().add(OnUploadFileEvent(
                  file: image,
                ));
          },
          icon: const Icon(
            Icons.camera_alt,
          ),
        ),
      ),
    );
  }
}
