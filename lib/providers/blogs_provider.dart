import 'package:blogexplorer/models/blog.dart';
import 'package:blogexplorer/services/api_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final blogsProvider = FutureProvider<List<Blog>>((ref) {
  return ref.watch(apiProvider).fetchBlogs();
});
