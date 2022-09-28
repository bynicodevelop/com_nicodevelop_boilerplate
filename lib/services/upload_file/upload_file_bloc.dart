// ignore: depend_on_referenced_packages
import "package:bloc/bloc.dart";
import "package:com_nicodevelop_dotmessenger/exceptions/standard_exception.dart";
import "package:com_nicodevelop_dotmessenger/repositories/upload_repository.dart";
import "package:equatable/equatable.dart";
import "package:image_picker/image_picker.dart";

part "upload_file_event.dart";
part "upload_file_state.dart";

class UploadFileBloc extends Bloc<UploadFileEvent, UploadFileState> {
  final UploadRepository uploadRepository;

  UploadFileBloc({
    required this.uploadRepository,
  }) : super(UploadFileInitialState()) {
    on<OnUploadFileEvent>((event, emit) async {
      emit(UploadFileLoadingState());

      try {
        final String photoURL = await uploadRepository.uploadFile({
          "file": event.file,
        });

        emit(UploadFileSuccessState(
          photoURL: photoURL,
        ));
      } on StandardException catch (e) {
        emit(UploadFileFailureState(
          code: e.code,
        ));
      }
    });
  }
}
