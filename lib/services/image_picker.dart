import 'package:image_picker/image_picker.dart';

class PickImage {
  Future<XFile?>? pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    return returnedImage;
  }
}
