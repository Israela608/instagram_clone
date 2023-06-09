import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/provider/auth_state_provider.dart';
import 'package:instagram_clone/state/image_upload/helpers/image_picker_helper.dart';
import 'package:instagram_clone/state/image_upload/models/file_type.dart';
import 'package:instagram_clone/state/post_settings/provider/post_setting_provider.dart';
import 'package:instagram_clone/views/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_clone/views/components/dialogs/logout_dialog.dart';
import 'package:instagram_clone/views/constants/strings.dart';
import 'package:instagram_clone/views/create_new_post/create_new_post_view.dart';
import 'package:instagram_clone/views/tabs/user_posts/user_posts_view.dart';

//For when you are already logged in
class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            Strings.appName,
          ),
          actions: [
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.film,
              ),
              onPressed: () async {
                // Pick a video first
                final videoFile =
                    await ImagePickerHelper.pickVideoFromGallery();

                if (videoFile == null) {
                  return;
                }

                // Re-create the PostSettingProvider when this button is pressed
                ref.refresh(postSettingProvider);

                // go to the screen to create a new post
                if (!mounted) {
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreateNewPostView(
                      fileToPost: videoFile,
                      fileType: FileType.video,
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: const FaIcon(
                Icons.add_photo_alternate_outlined,
              ),
              onPressed: () async {
                // Pick an image first
                final imageFile =
                    await ImagePickerHelper.pickImageFromGallery();

                if (imageFile == null) {
                  return;
                }

                // Re-create the PostSettingProvider when this button is pressed
                ref.refresh(postSettingProvider);

                // go to the screen to create a new post
                if (!mounted) {
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreateNewPostView(
                      fileToPost: imageFile,
                      fileType: FileType.image,
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: const FaIcon(
                Icons.logout,
              ),
              onPressed: () async {
                // This will show a dialog for the user to choose whether to logout or cancel
                // true means logout, false means cancel dialog
                final shouldLogOut = await const LogoutDialog()
                    .present(context)
                    .then((value) => value ?? false);

                //If the user clicked the logout button in the Logout dialog
                if (shouldLogOut) {
                  // logout
                  await ref.read(authStateProvider.notifier).logOut();
                }
              },
            ),
          ],
          bottom: const TabBar(tabs: [
            Tab(
              icon: Icon(
                Icons.person,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.search,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.home,
              ),
            ),
          ]),
        ),
        body: const TabBarView(
          children: [
            UserPostsView(),
            UserPostsView(),
            UserPostsView(),
          ],
        ),
      ),
    );

    /*return Scaffold(
      appBar: AppBar(
        title: const Text('Main View'),
        centerTitle: true,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return TextButton(
            onPressed: () async {
              */ /*LoadingScreen.instance().show(
                context: context,
                text: 'Hello World',
              );*/ /*
              await ref.read(authStateProvider.notifier).logOut();
            },
            child: const Text(
              'Logout',
            ),
          );
        },
      ),
    );*/
  }
}
