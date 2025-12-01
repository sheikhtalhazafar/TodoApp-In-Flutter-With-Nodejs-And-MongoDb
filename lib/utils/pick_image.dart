import 'package:image_picker/image_picker.dart';

class PickImage {
  Future<List<String>> pickImage() async {
  XFile? pickedImage;

    final ImagePicker picker = ImagePicker();
    pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return [pickedImage.path, pickedImage.name] ; // <-- store file name
    }
    return [];
  }
}
