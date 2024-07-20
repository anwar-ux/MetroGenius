import 'package:image_picker/image_picker.dart';

Future imagePicker() async {
  final imageUrl = await ImagePicker().pickImage(source: ImageSource.gallery);
  return imageUrl;
}