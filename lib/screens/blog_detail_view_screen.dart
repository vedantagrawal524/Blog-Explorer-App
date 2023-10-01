import 'package:blogexplorer/models/blog.dart';
import 'package:blogexplorer/providers/favorites_blogs_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

class BlogDetailViewScreen extends ConsumerWidget {
  const BlogDetailViewScreen({
    super.key,
    required this.blog,
  });
  final Blog blog;

  void toggleBlogFavStatus(BuildContext context, Blog blog, WidgetRef ref) {
    final wasAdded =
        ref.read(favoriteBlogsNotifier.notifier).toggleBlogFavoriteStatus(blog);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(wasAdded
            ? 'Marked as a Favorite Blog!'
            : 'No Longer a Favorite Blog!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteBlogs = ref.watch(favoriteBlogsNotifier);
    final isFavorite = favoriteBlogs.contains(blog);
    return Scaffold(
      appBar: AppBar(
        title: Text(blog.title),
        actions: [
          IconButton(
            onPressed: () {
              toggleBlogFavStatus(context, blog, ref);
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween<double>(begin: 0.9, end: 1).animate(animation),
                  child: child,
                );
              },
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                key: ValueKey(isFavorite),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: blog.id,
              child: InteractiveViewer(
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(blog.imageUrl),
                  fit: BoxFit.cover,
                  height: 300,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              shadowColor: Colors.indigo,
              margin: const EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 5,
              clipBehavior: Clip.antiAlias,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.indigo,
                      Color.fromARGB(255, 59, 14, 59),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Text(
                  blog.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          toggleBlogFavStatus(context, blog, ref);
        },
        backgroundColor: const Color.fromARGB(255, 53, 70, 167),
        child: Icon(
          isFavorite ? Icons.star : Icons.star_border,
          key: ValueKey(isFavorite),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
