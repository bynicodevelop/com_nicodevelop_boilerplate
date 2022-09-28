part of "upload_file_bloc.dart";

abstract class UploadFileState extends Equatable {
  const UploadFileState();

  @override
  List<Object> get props => [];
}

class UploadFileInitialState extends UploadFileState {}

class UploadFileLoadingState extends UploadFileState {}

class UploadFileSuccessState extends UploadFileState {
  final String photoURL;

  const UploadFileSuccessState({
    required this.photoURL,
  });

  @override
  List<Object> get props => [
        photoURL,
      ];
}

class UploadFileFailureState extends UploadFileState {
  final String code;

  const UploadFileFailureState({
    required this.code,
  });

  @override
  List<Object> get props => [
        code,
      ];
}
