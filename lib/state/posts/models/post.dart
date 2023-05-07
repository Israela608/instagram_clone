import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/state/image_upload/models/file_type.dart';
import 'package:instagram_clone/state/post_settings/models/post_setting.dart';
import 'package:instagram_clone/state/posts/models/post_key.dart';

@immutable
class Post {
  Post({required this.postId, required Map<String, dynamic> json})
      : userId = json[PostKey.userId],
        message = json[PostKey.message],
        createdAt = (json[PostKey.createdAt] as Timestamp).toDate(),
        thumbnailUrl = json[PostKey.thumbnailUrl],
        fileUrl = json[PostKey.fileUrl],
        // Loop through all the values of the FileType enum starting from the first value
        //the function being passed to firstWhere takes an argument called fileType,
        // which represents each enum value in FileType.values, and checks if the name
        // property of fileType is equal to the value associated with the fileType key in the JSON map (json[PostKey.fileType]).
        // If it finds an enum value with a matching name, it returns that value as the fileType for the Post instance being created.
        // If it doesn't find a matching value, it returns the default value of FileType.image.
        fileType = FileType.values.firstWhere(
          (fileType) => fileType.name == json[PostKey.fileType],
          orElse: () => FileType.image,
        ),
        fileName = json[PostKey.fileName],
        aspectRatio = json[PostKey.aspectRatio],
        thumbnailStorageId = json[PostKey.thumbnailStorageId],
        originalFileStorageId = json[PostKey.originalFileStorageId],
        // The postSettings parameter in the Post constructor is used to set the postSettings
        // property of the Post instance being created. It creates a new Map using a "map comprehension"
        // to iterate over the entries in the postSettings key of a JSON map and map them to corresponding PostSetting enum values.
        // It checks each entry's key against the storageKey property of the enum values using the firstWhere method,
        // and sets the corresponding value in the new Map.
        postSettings = {
          for (final entry in json[PostKey.postSettings].entries)
            PostSetting.values.firstWhere(
              (element) => element.storageKey == entry.key,
            ): entry.value,
        };

  final String postId;
  final String userId;
  final String message;
  final DateTime createdAt;
  final String thumbnailUrl;
  final String fileUrl;
  final FileType fileType;
  final String fileName;
  final double aspectRatio;
  final Map<PostSetting, bool> postSettings;
  final String thumbnailStorageId;
  final String originalFileStorageId;

  bool get allowLikes => postSettings[PostSetting.allowLikes] ?? false;
  bool get allowComments => postSettings[PostSetting.allowComments] ?? false;
}
