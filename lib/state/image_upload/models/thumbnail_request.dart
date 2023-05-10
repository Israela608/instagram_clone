import 'dart:io';

import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/state/image_upload/models/file_type.dart';

@immutable
class ThumbnailRequest {
  const ThumbnailRequest({
    required this.file,
    required this.fileType,
  });

  final File file;
  final FileType fileType;

  // Equality
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThumbnailRequest &&
          runtimeType == other.runtimeType &&
          file == other.file &&
          fileType == other.fileType;

  //Hashing
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        file,
        fileType,
      ]);
}
