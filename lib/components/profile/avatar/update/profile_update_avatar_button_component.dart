import "package:com_nicodevelop_dotmessenger/services/upload_file/upload_file_bloc.dart";
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
          print(state);
          // TODO: implement listener
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
