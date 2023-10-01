import 'package:blogexplorer/models/blog.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class BlogViewItem extends StatelessWidget {
  const BlogViewItem({
    super.key,
    required this.blog,
    required this.onSelectBlog,
  });
  final Blog blog;
  final void Function(Blog meal) onSelectBlog;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectBlog(blog);
        },
        child: Stack(
          children: [
            Hero(
              tag: blog.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(blog.imageUrl),
                fit: BoxFit.cover,
                height: 220,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Text(
                  blog.title,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
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
    );
  }
}
