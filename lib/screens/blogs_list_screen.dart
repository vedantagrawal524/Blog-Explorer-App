import 'package:blogexplorer/models/blog.dart';
import 'package:flutter/material.dart';

class BlogsListScreen extends StatefulWidget {
  const BlogsListScreen({super.key, required this.blogs});
  final List<Blog> blogs;

  @override
  State<BlogsListScreen> createState() {
    return _BlogsListScreenState();
  }
}

class _BlogsListScreenState extends State<BlogsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
