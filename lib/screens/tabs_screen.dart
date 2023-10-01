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
  @override
  void initState() {
    super.initState();
  }

  int _selectedScreenIndex = 0;
  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final blogs = ref.watch(blogsProvider);
    // Widget activeScreen = BlogsListScreen();
    var activePageTitle = 'Blogs';

    if (_selectedScreenIndex == 1) {
      final favoriteBlogs = ref.watch(favoriteBlogsNotifier);
      // activeScreen = BlogsListScreen();
      activePageTitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: blogs.when(
        data: (blogs) {
          List<Blog> apiBlogs = blogs.map((e) => e).toList();
          return BlogsViewListScreen(
            blogs: apiBlogs,
          );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
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
