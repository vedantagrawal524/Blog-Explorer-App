import 'dart:convert';

import 'package:blogexplorer/models/blog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  final String adminSecret =
      '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  Future<List<Blog>> fetchBlogs() async {
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        final List blogs = jsonDecode(response.body)['blogs'];
        print('Response data: ${response.body}');
        return blogs.map((e) => Blog.fromJson(e)).toList();
      } else {
        print('Request failed with status code: ${response.statusCode}');
        print('Response data: ${response.body}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return [];
  }
}

final apiProvider = Provider<ApiServices>((ref) => ApiServices());
