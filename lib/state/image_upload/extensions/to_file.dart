import 'dart:io';
import 'package:image_picker/image_picker.dart';

// We convert Future of XFile to a Future of File
extension ToFile on Future<XFile?> {
  Future<File?> toFile() =>
      // The first then() method takes a callback function that converts the XFile object to a file path string. If the XFile object is null, the callback returns null.
      then((xFile) => xFile?.path)
          // The second then() method takes another callback function that creates a new File object from the file path string if it's not null. If the file path string is null, the callback returns null.
          .then(
        (filePath) => filePath != null ? File(filePath) : null,
      );
}
