import 'package:flutter/material.dart';

class BlogsListScreen extends StatefulWidget {
  const BlogsListScreen({super.key});

  @override
  State<BlogsListScreen> createState() {
    return _BlogsListScreenState();
  }
}

class _BlogsListScreenState extends State<BlogsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Explorer'),
      ),
    );
  }
}
