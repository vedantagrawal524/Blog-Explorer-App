import 'package:blogexplorer/models/blog.dart';
import 'package:blogexplorer/providers/blogs_provider.dart';
import 'package:blogexplorer/providers/favorites_blogs_provider.dart';
import 'package:blogexplorer/screens/blogs_view_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedScreenIndex = 0;
  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final blogs = ref.watch(blogsProvider);
    Widget activeScreen = blogs.when(
      data: (blogs) {
        List<Blog> apiBlogs = blogs.map((e) => e).toList();
        return BlogsViewListScreen(
          blogs: apiBlogs,
        );
      },
      error: (error, stackTrace) {
        return Text(
          'Something gone Wrong, Please try again later!',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    var activePageTitle = 'Blogs';

    if (_selectedScreenIndex == 1) {
      final favoriteBlogs = ref.watch(favoriteBlogsNotifier);
      activeScreen = BlogsViewListScreen(blogs: favoriteBlogs);
      activePageTitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        currentIndex: _selectedScreenIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: 'Blogs',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
