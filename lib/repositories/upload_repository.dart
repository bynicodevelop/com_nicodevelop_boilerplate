import "dart:convert";
import "dart:io";

import "package:com_nicodevelop_dotmessenger/exceptions/standard_exception.dart";
import "package:com_nicodevelop_dotmessenger/utils/logger.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:crypto/crypto.dart" as crypto;
import "package:image_picker/image_picker.dart";

class UploadRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

  const UploadRepository({
    required this.firebaseAuth,
    required this.firebaseStorage,
  });

  Future<String> _convertFileNameToMD5(XFile file) async {
    final String ext = file.name.split(".").last;

    String filenameHashed =
        crypto.md5.convert(utf8.encode(file.path)).toString();

    return "$filenameHashed.$ext";
  }

  Future<String> uploadFile(Map<String, dynamic> data) async {
    assert(data["file"] != null);

    User? user = firebaseAuth.currentUser;

    if (user == null) {
      throw StandardException(
        "User not authenticated",
        "unauthenticated",
      );
    }

    String filename = await _convertFileNameToMD5(data["file"]);

    String userId = user.uid;

    String path = "users/$userId/avatars/$filename";

    info("$runtimeType Uploading file $filename for user $userId", data: {
      "path": path,
    });

    Reference ref = firebaseStorage.ref(path);

    UploadTask uploadTask = ref.putFile(
      File(data["file"].path),
    );

    await uploadTask;

    return filename;
  }
}
