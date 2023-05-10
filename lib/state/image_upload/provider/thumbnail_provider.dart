import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/image_upload/exceptions/could_not_build_thumbnail_exception.dart';
import 'package:instagram_clone/state/image_upload/extensions/get_image_aspect_ratio.dart';
import 'package:instagram_clone/state/image_upload/models/file_type.dart';
import 'package:instagram_clone/state/image_upload/models/image_with_aspect_ratio.dart';
import 'package:instagram_clone/state/image_upload/models/thumbnail_request.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

// This provider is a family because we need an input parameter 'ThumbnailRequest'
// and we return an ImageWithAspectRatio as output. So it is a family
// We have an autoDispose because we want to get rid of it when we are done
// All of these are inside a Future, that's why we created a FutureProvider
// When we call this function 'thumbnailProvider' we will get a Future of ImageWithAspectRatio back
final thumbnailProvider = FutureProvider.family
    .autoDispose<ImageWithAspectRatio, ThumbnailRequest>(
        (ref, ThumbnailRequest request) async {
  final Image image;

  // Check for the type of file
  switch (request.fileType) {
    // If file is an image
    case FileType.image:
      image = Image.file(
        request.file,
        fit: BoxFit.fitHeight,
      );
      break;
    case FileType.video:
      final thumb = await VideoThumbnail.thumbnailData(
        video: request.file.path,
        imageFormat: ImageFormat.JPEG,
        quality: 75,
      );

      if (thumb == null) {
        throw const CouldNotBuildThumbnailException();
      }

      image = Image.memory(
        thumb,
        fit: BoxFit.fitHeight,
      );
      break;
  }

  final aspectRatio = await image.getAspectRatio();

  return ImageWithAspectRatio(
    image: image,
    aspectRatio: aspectRatio,
  );
});
