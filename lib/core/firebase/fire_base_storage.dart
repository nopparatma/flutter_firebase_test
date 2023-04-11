import 'package:firebase_storage/firebase_storage.dart';

class FireBaseStorage {
  Future<String> getImgUrl(String imgName) async {
    return await FirebaseStorage.instance.ref().child(imgName).getDownloadURL();
  }
}
