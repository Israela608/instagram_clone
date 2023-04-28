// Defines a list of all the Lottie animations that the app can use,
// which can be useful for organizing and managing the animations.
enum LottieAnimation {
  dataNotFound(name: 'data_not_found'),
  empty(name: 'empty'),
  loading(name: 'loading'),
  error(name: 'error'),
  smallError(name: 'small_error');

  const LottieAnimation({
    required this.name,
  });
  final String name;
}
