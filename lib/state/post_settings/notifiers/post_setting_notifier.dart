import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/post_settings/models/post_setting.dart';

//Notifier for Post settings (Like and comments toggle)
class PostSettingNotifier extends StateNotifier<Map<PostSetting, bool>> {
  PostSettingNotifier()
      : super(
          UnmodifiableMapView(
            {
              // For every new post, set the initial values of each setting (likes and comments) to true
              for (final setting in PostSetting.values) setting: true,
            },
          ),
        );

  // We use this method to set each of the setting (likes and comments) to either true or false
  void setSetting(
    PostSetting setting,
    bool value,
  ) {
    final existingValue = state[setting];

    // if the setting has not being assigned to any value (true or false) or the value of the setting is the same as the one passed, don't do anything.
    if (existingValue == null || existingValue == value) {
      return;
    }

    // Set the setting to the value that is passed
    state = Map.unmodifiable(
      Map.from(state)..[setting] = value,
    );
  }
}
