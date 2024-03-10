import 'dart:convert';
import 'dart:io';

import 'package:mime/mime.dart';

class ImageToBase64Util {
  static Future<String> imageFileToBase64(String imagePath) async {
    // Read the file as bytes
    File imageFile = File(imagePath);
    List<int> imageBytes = await imageFile.readAsBytes();

    // Encode the bytes to base64
    String base64Image = base64Encode(imageBytes);

    // Determine MIME type based on file extension
    String mimeType = lookupMimeType(imagePath) ?? 'application/octet-stream';

    // Add prefix to base64 image string
    String imageWithPrefix = addBase64Prefix(base64Image, mimeType);

    return imageWithPrefix;
  }

  // Function to add prefix to base64 image string
  static String addBase64Prefix(String base64Image, String mimeType) {
    return 'data:$mimeType;base64,$base64Image';
  }
}
