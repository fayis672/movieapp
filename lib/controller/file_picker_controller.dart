import 'dart:io';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerController extends GetxController {
  var filename = 'no poster selected'.obs;
  var file = Rx<File?>(null);

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'png', 'jpeg']);
    if (result != null) {
      file.value = File(result.files.single.path);
      filename.value = file.value!.path.split("/").last;
    }
  }
}
