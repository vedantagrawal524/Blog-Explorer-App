import 'package:blogexplorer/models/blog.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class BlogDatabaseSevices {
  Future<Database> _getDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, 'blogsexplorer.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE blogs(id TEXT PRIMARY KEY,title TEXT,image_url TEXT)');
      },
      version: 1,
    );
    return db;
  }

  Future<int> insertBlog(Blog blog) async {
    final db = await _getDatabase();
    return await db.insert('blogs', blog.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Blog>> loadBlogs() async {
    final db = await _getDatabase();
    final data = await db.query('blogs');
    final blogs = data
        .map(
          (row) => Blog(
            id: row['id'] as String,
            title: row['title'] as String,
            imageUrl: row['image_url'] as String,
          ),
        )
        .toList();
    return blogs;
  }
}
