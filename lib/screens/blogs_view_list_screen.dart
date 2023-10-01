import 'package:blogexplorer/models/blog.dart';
import 'package:blogexplorer/screens/blog_detail_view_screen.dart';
import 'package:blogexplorer/widgets/blog_view_Item.dart';
import 'package:flutter/material.dart';

class BlogsViewListScreen extends StatelessWidget {
  const BlogsViewListScreen({
    super.key,
    required this.blogs,
  });
  final List<Blog> blogs;

  void _selectBlog(BuildContext context, Blog blog) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => BlogDetailViewScreen(
          blog: blog,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: blogs.length,
        itemBuilder: (context, index) => BlogViewItem(
          blog: blogs[index],
          onSelectBlog: (blog) {
            _selectBlog(context, blog);
          },
        ),
      ),
    );
  }
}
