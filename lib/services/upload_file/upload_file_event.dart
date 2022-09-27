part of "upload_file_bloc.dart";

abstract class UploadFileEvent extends Equatable {
  const UploadFileEvent();

  @override
  List<Object> get props => [];
}

class OnUploadFileEvent extends UploadFileEvent {
  final XFile file;

  const OnUploadFileEvent({
    required this.file,
  });

  @override
  List<Object> get props => [
        file,
      ];
}
