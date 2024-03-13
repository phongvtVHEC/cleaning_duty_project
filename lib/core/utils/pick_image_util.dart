import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:lecle_flutter_absolute_path/lecle_flutter_absolute_path.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';

class PickImageUtil {
  static Future<dynamic> pickImage() async {
    if (Platform.isIOS) {
      List<Asset> images = List.empty();

      images = await MultiImagePicker.pickImages(
        selectedAssets: images,
        iosOptions: const IOSOptions(
          settings: CupertinoSettings(
            selection: SelectionSetting(max: 1, unselectOnReachingMax: true),
          ),
          doneButton: UIBarButtonItem(title: 'Confirm'),
          cancelButton: UIBarButtonItem(title: 'Cancel'),
        ),
      );

      final filePath = await LecleFlutterAbsolutePath.getAbsolutePath(
          uri: images.first.identifier);
      return filePath;
    } else {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      return image?.path;
    }
  }
}
