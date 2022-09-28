import "package:com_nicodevelop_dotmessenger/models/user_model.dart";
import "package:com_nicodevelop_dotmessenger/services/authentication_status/authentication_status_bloc.dart";
import "package:com_nicodevelop_dotmessenger/services/update_account/update_account_bloc.dart";
import "package:com_nicodevelop_dotmessenger/services/upload_file/upload_file_bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:image_picker/image_picker.dart";

class ProfileUpdateAvatarButtonComponent extends StatelessWidget {
  final Function onAvatarUpdated;
  final Function(String) onAvatarUpdateError;

  const ProfileUpdateAvatarButtonComponent({
    super.key,
    required this.onAvatarUpdated,
    required this.onAvatarUpdateError,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      child: BlocListener<UpdateAccountBloc, UpdateAccountState>(
        listener: (context, state) {
          if (state is UpdateAccountFailureState) {
            onAvatarUpdateError(state.code);
          }

          if (state is UpdateAccountSuccessState) {
            onAvatarUpdated();
          }
        },
        child: BlocListener<UploadFileBloc, UploadFileState>(
          listener: (context, state) async {
            if (state is UploadFileFailureState) {
              onAvatarUpdateError(state.code);

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
      ),
    );
  }
}
