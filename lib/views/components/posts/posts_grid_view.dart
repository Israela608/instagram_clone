import 'package:flutter/material.dart';
import 'package:instagram_clone/state/posts/models/post.dart';
import 'package:instagram_clone/views/components/posts/post_thumbnail_view.dart';

class PostsGridView extends StatelessWidget {
  const PostsGridView({
    Key? key,
    required this.posts,
  }) : super(key: key);

  final Iterable<Post> posts;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts.elementAt(index);

        return PostThumbnailView(
            post: post,
            onTapped: () {
              /// TODO: Navigate to the post details view
            });
      },
    );
  }
}
