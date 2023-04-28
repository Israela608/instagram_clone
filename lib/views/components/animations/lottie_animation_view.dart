import 'package:flutter/material.dart';
import 'package:instagram_clone/views/components/animations/models/lottie_animation.dart';
import 'package:lottie/lottie.dart';

// A reusable widget for displaying any Lottie animation we have
class LottieAnimationView extends StatelessWidget {
  const LottieAnimationView({
    Key? key,
    required this.animation,
    this.repeat = true,
    this.reverse = false,
  }) : super(key: key);

  final LottieAnimation animation;
  final bool repeat;
  final bool reverse;

  @override
  Widget build(BuildContext context) => Lottie.asset(
        animation.fullPath,
        reverse: reverse,
        repeat: repeat,
      );
}

//This is just an extension of the LottieAnimation enum
// You can put the "String get fullPath => 'assets/animations/$name.json';" code in the actual LottieAnimation enum and it will still be the same
// We are only putting it here, because we will only use this fullPath property here in this file
extension GetFullPath on LottieAnimation {
  String get fullPath => 'assets/animations/$name.json';
}
