import 'package:instagram_clone/views/components/animations/lottie_animation_view.dart';
import 'package:instagram_clone/views/components/animations/models/lottie_animation.dart';

// A specific widget for displaying the dataNotFound animation
class DataNotFoundAnimationView extends LottieAnimationView {
  const DataNotFoundAnimationView({super.key})
      : super(
          animation: LottieAnimation.dataNotFound,
        );
}
