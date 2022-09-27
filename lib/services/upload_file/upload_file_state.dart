part of "upload_file_bloc.dart";

abstract class UploadFileState extends Equatable {
  const UploadFileState();

  @override
  List<Object> get props => [];
}

class UploadFileInitialState extends UploadFileState {}

class UploadFileLoadingState extends UploadFileState {}

class UploadFileSuccessState extends UploadFileState {
  final String filename;

  const UploadFileSuccessState({
    required this.filename,
  });

  @override
  List<Object> get props => [
        filename,
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
