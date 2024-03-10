import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';

class PickImageUtil {
  static Future<dynamic> pickImage() async {
    if (Platform.isIOS) {
      List<Asset> images = List.empty();
      MultiImagePicker.pickImages(
        selectedAssets: images,
        iosOptions: const IOSOptions(
          settings: CupertinoSettings(selection: SelectionSetting(max: 1)),
          doneButton: UIBarButtonItem(title: 'Confirm'),
          cancelButton: UIBarButtonItem(title: 'Cancel'),
        ),
      );
      return images;
    } else {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      return image?.path;
    }
  }
}
