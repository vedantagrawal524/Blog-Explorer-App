import 'dart:convert';
import 'package:blogexplorer/models/blog.dart';
import 'package:blogexplorer/services/blog_database_services.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final blogsProvider = FutureProvider<List<Blog>>((ref) async {
  final db = BlogDatabaseSevices();
  final connectivityResult = await Connectivity().checkConnectivity();
  final isOnline = connectivityResult != ConnectivityResult.none;
  const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  const String adminSecret =
      '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  if (isOnline) {
    final response = await http.get(Uri.parse(url), headers: {
      'x-hasura-admin-secret': adminSecret,
    });
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body)['blogs'];
      final blogs =
          responseData.map((blogData) => Blog.fromJson(blogData)).toList();

      for (var blog in blogs) {
        await db.insertBlog(blog);
      }

      return blogs;
    } else {
      throw Exception('Something gone Wrong, Please try again later!');
    }
  } else {
    final offlineBlogs = await db.loadBlogs();
    return offlineBlogs;
  }
});
