import 'package:blogexplorer/models/blog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteBlogsNotifier extends StateNotifier<List<Blog>> {
  FavoriteBlogsNotifier() : super([]);
  bool toggleBlogFavoriteStatus(Blog blog) {
    final isBlogFavorite = state.contains(blog);
    if (isBlogFavorite) {
      state = state.where((m) => m.id != blog.id).toList();
      return false;
    } else {
      state = [...state, blog];
      return true;
    }
  }
}

final favoriteBlogsNotifier =
    StateNotifierProvider<FavoriteBlogsNotifier, List<Blog>>(
  (ref) {
    return FavoriteBlogsNotifier();
  },
);
