import 'package:flutter/material.dart';

@immutable
class ImageWithAspectRatio {
  const ImageWithAspectRatio({
    required this.image,
    required this.aspectRatio,
  });

  final Image image;
  final double aspectRatio;
}
